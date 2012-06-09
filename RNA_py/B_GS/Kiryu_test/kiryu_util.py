import os
import shutil
from B_GS_util import *
####################################################################################
#1) Parse Kiryu data
def clean(aln,true):
    back=''
    for i in range(len(aln)):
        if aln[i]!='.':
            back+=true[i]
    return back
    
def parse_data(filename,num_seq,ind_seqs):
    read=open(filename,'r')
    reader=read.readline()
    oridir=os.getcwd()
    index=0
    while reader:        
        if '# STOCKHOLM 1.0' in reader:
            print index
            newdir=os.path.join(oridir,str(index))
            os.mkdir(newdir)
            print newdir
            seq_write=open(newdir+'/seq.fa','w')
            #seq_write2=open(newdir+'/00aln','w')
            #seq_write2.write('>alignment 0\n')
            reader=read.readline()
            seqs=['']*num_seq
            names=['']*num_seq
            true=''
            count=-1
            while '//' not in reader:
                if reader[0]=='\n' or '#' in reader:
                    if '#=GC SS_cons' in reader:
                        true+=reader[reader.rfind(' ')+1:-1]
                    reader=read.readline()
                    count=-1
                else:
                    #print count
                    count+=1 
                    seqs[count]+=reader[reader.rfind(' ')+1:-1]
                    names[count]=reader[0:reader.rfind(' ')].strip()
                    reader=read.readline()                
            else:
                for ind_seq in ind_seqs:
                    tr_write=open(newdir+'/tru_str_'+str(ind_seq+1),'w')
                    tr_write.write(bratrans(project(seqs[ind_seq],true)))
                    tr_write.close()
                for i in range(num_seq):
                    seq_write.write('>'+names[i]+'\n')
                    seq_write.write(clean(seqs[i],seqs[i])+'\n')                
                    #seq_write2.write(seqs[i]+'\n')                
                seq_write.close()
                #seq_write2.close()
                index+=1
                reader=read.readline()     
        else:
            reader=read.readline()
    read.close()
    return index
                                       
####################################################################################
#2) Initialize Alignment with Probcons

def ini_aln(infile):
    a=open(infile)
    b=open('00aln','w')
    b.write('>alignment 0\n')
    line=a.readline()
    line=a.readline()
    while line:
        if line[0]!='>':
            b.write(line[:-1])
        else:
            b.write('\n')        
        line=a.readline()
    b.write('\n')
    a.close()
    b.close()    
    
def subtract(inseq,num):
    ins=open(inseq,'r')
    ous=open('seq_'+str(num)+'.fa','w')
    for i in range(2*num):
        ous.write(ins.readline())        
    ins.close()
    ous.close()    

def sub(Dir,tmp_Dir,subalign):
    os.chdir(tmp_Dir)
    tmp=tmp_Dir
    for ii in subalign:
        newdir=os.path.join(tmp_Dir,str(ii))
        os.mkdir(newdir)    
        print 'haha'
        os.chdir(newdir)
        subtract(tmp+'seq.fa',ii)
        os.popen(Dir+' seq_'+str(ii)+'.fa > ha.aln ')
        ini_aln('ha.aln')
        os.remove('ha.aln')
        tmp_Dir+=str(ii)+'/'

