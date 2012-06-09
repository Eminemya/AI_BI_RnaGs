import sys
import os
sys.path.append('/users/dwei/roc_seq')
import parse_rna
import shutil
def GS(Dir,num_seq,ind_seqs,iter,cons=0):
    os.chdir(Dir)
    #A) Gibbs Sampling       
    #A.1) Initialization 1: from 00aln
    aa=open(Dir+'00aln','r')
    a=aa.readlines()
    aa.close()
    if os.path.exists('0.aln'):
        os.remove('0.aln')    
    parse_rna.C_aln(Dir+str(0)+'.aln',Dir+'seq_'+str(num_seq)+'.fa',a,num_seq)               
    """
    #A.1) Initialization 2: from 0.aln generated from Probcons
    a=open(Dir+'0.aln')
    lines=a.readlines()
    a.close()    
    b=open(Dir+'0.aln','w')
    b.write('CLUSTAL 2.0.12 multiple sequence alignment\n\n')    
    w=0
    for i in range(2,len(lines)):
        tmp=lines[i]
        if tmp=='\n':
            b.write(tmp)
        else:
            if tmp[0]!=' ':        
                tmp2=tmp[:tmp.rfind(' ')]
                w=tmp.rfind(' ')
                b.write(tmp2+' '*(29-len(tmp2))+tmp[tmp.rfind(' '):tmp.find('\n')]+' 10\n')
            else:                
                b.write(29*' '+tmp[w:])                     
    b.close()
    """
    for i in range(cons,iter):
        print i
        #1)RNAalifold:aln->str
        fold = os.popen('/ccmb/data/ViennaRNA-1.8.4/Progs/RNAalifold -s 1 '+Dir+str(i)+'.aln')
        #1.1)Record the consensus structure 
        result=fold.readline()
        result=fold.readline()
        result=fold.readline()
        #print result
        str_file=open(Dir+'00str','a')
        str_file.write('>structure '+str(i)+'\n')
        str_file.write(result.strip()+'\n')
        str_file.close()
        #1.2)Prepare for Step 2)
        parse_rna.C_sto(Dir+str(i)+'.aln',Dir+str(i)+'.sto',result,num_seq,1)
        sto = os.popen('/ccmb/data/infernal-1.0.2/src/cmbuild -F '+Dir+str(i)+'.cm '+Dir+str(i)+'.sto')
        sys.stdout.flush()    
        for line in sto.readlines(): 
            print line
        #2)CM:str->aln
        cm = os.popen('/ccmb/data/infernal-1.0.2/src/cmalign --sample '+Dir+str(i)+'.cm '+Dir+'seq_'+str(num_seq)+'.fa')
        ll=cm.readlines()
        #2.1)Record the consensus structure&Prepare for Step 1)
        alns=parse_rna.find_aln(Dir+str(i+1)+'.aln',ll,num_seq)
        aln_file=open(Dir+'00aln','a')
        aln_file.write('>>alignment  '+str(i+1)+'\n')
        for ii in range(0,num_seq):
            aln_file.write(alns[ii]+'\n')   
        aln_file.close()
         #2.2)Clean up
        os.remove(Dir+str(i)+'.aln')        
        os.remove(Dir+str(i)+'.sto')
        if i!=iter-1:
            os.remove(Dir+str(i)+'.cm')        
        os.remove(Dir+'alirna.ps')
            
    #B) Matlab Analysis(which has nicer plots)
    #################################################################################
    for ind_seq in ind_seqs:
        parse_rna.project_strus(Dir+'project_'+str(ind_seq)+'.str',Dir+'00aln',Dir+'00str',ind_seq,num_seq) 
"""        
iter=2000
GS('./',2,range(1,3),iter)    
for i in range(3,11):
    tmp_Dir='./'+str(i)+'/'    
    os.chdir(tmp_Dir)
    GS('./',i,range(1,i+1),iter)    
"""    
