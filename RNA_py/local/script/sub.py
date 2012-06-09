import os
import shutil
num_folder=1
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

def ran_sub(Dir,tmp_Dir,numseq):
    os.chdir(tmp_Dir)
    os.popen(Dir+' seq_'+str(numseq)+'.fa > ha.aln ')
    ini_aln('ha.aln')
    os.remove('ha.aln')

def sub(Dir,tmp_Dir):
    os.chdir(tmp_Dir)
    tmp=tmp_Dir
    subtract('seq.fa',2)
    #os.popen(Dir+' -clustalw seq_2.fa > 0.aln ')
    os.popen(Dir+' seq_2.fa > ha.aln ')
    ini_aln('ha.aln')
    os.remove('ha.aln')
    for ii in [5,7,10]:
    #for ii in range(3,11):
        newdir=os.path.join(tmp_Dir,str(ii))
        if not os.path.exists(newdir):
            os.mkdir(newdir)
        print 'haha'
        os.chdir(newdir)
        subtract(tmp+'seq.fa',ii)
        #os.popen(Dir+' -clustalw seq_'+str(ii)+'.fa > 0.aln ')
        os.popen(Dir+' seq_'+str(ii)+'.fa > ha.aln ')
        ini_aln('ha.aln')
        os.remove('ha.aln')
        tmp_Dir+=str(ii)+'/'

