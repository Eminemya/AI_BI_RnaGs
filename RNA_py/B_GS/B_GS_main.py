from B_GS_util import *

def B_GS(seq_file,R_Dir,C_Dir,iteration,P_Dir=0):
    Dir=seq_file[:seq_file.rfind('/')+1]
    ########################################################################
    #A)Pre-pocession: PROBCONS->00_aln->0.aln
    # if somehow PROBCONS is not available,then do the 00_aln by yourself
    if P_Dir!=0:
        Ini_aln(P_Dir,seq_file)            
    aa=open(Dir+'00aln','r')
    a=aa.readlines()
    aa.close()
    num_seq=len(a)-1
    Aln_aln(Dir+str(0)+'.aln',seq_file,a,num_seq)               
    ########################################################################
    #B) Iteration:i.aln->i.sto,i.cm->(i+1).aln
    for i in range(iteration):
        print i
        #1)RNAalifold:aln->str
        fold = os.popen(R_Dir+'RNAalifold -s 1 '+Dir+str(i)+'.aln')
        #ccmb:R_Dir='/ccmb/data/ViennaRNA-1.8.4/Progs/'
        #1.1)Record the consensus structure 
        result=fold.readline()
        result=fold.readline()
        result=fold.readline()
        print result
        str_file=open(Dir+'00str','a')
        str_file.write('>structure '+str(i)+'\n')
        str_file.write(result.strip()+'\n')
        str_file.close()
        #1.2)Prepare for Step 2)
        Alifold_sto(Dir+str(i)+'.aln',Dir+str(i)+'.sto',result,num_seq)
        sto = os.popen(C_Dir+'cmbuild -F '+Dir+str(i)+'.cm '+Dir+str(i)+'.sto')
        #ccmb:R_Dir='/ccmb/data/infernal-1.0.2/src/'
        #flush to make sure that .cm is already there
        sys.stdout.flush()    
        for line in sto.readlines(): 
            print line
        #2)CM:str->aln
        cm = os.popen(C_Dir+'cmalign --sample '+Dir+str(i)+'.cm '+seq_file)
        #2.1)Record the consensus structure&Prepare for Step 1)
        alns=CM_aln(Dir+str(i+1)+'.aln',cm.readlines(),num_seq)
        aln_file=open(Dir+'00aln','a')
        aln_file.write('>>alignment  '+str(i+1)+'\n')
        for ii in range(0,num_seq):
            aln_file.write(alns[ii]+'\n')   
        aln_file.close()
         #2.2)Clean up
        os.remove(Dir+str(i)+'.aln')        
        os.remove(Dir+str(i)+'.sto')
        os.remove(Dir+str(i)+'.cm')
        os.remove(Dir+'alirna.ps')            
    os.remove(Dir+str(iteration)+'.aln')
    #################################################################################
    #C) Projection:     
    for ind_seq in range(1,num_seq+1):
        project_strus(Dir+'project_'+str(ind_seq)+'.str',Dir+'00aln',Dir+'00str',ind_seq,num_seq)    
