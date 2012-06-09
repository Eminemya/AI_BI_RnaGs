import os
import parse_rna

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
                    tr_write.write(parse_rna.bratrans(parse_rna.project(seqs[ind_seq],true)))
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
                   
                      


num_seq=10
num_folder=85
#1)create the directory and original sequence
parse_data('dataset1_stockholm.txt',num_seq,range(10))
"""
for i in range(num_folder):
    tmp_Dir=Dir+str(i)+'/'   
    for ii in [2]:
        os.chdir(tmp_Dir)
        in_10=open('seq.fa','r')
        out_sub=open(seq.fa','w')
        for iii in range(2*ii):
            out_sub.write(in_10.readline())
        out_sub.close()
        in_10.close()                      
    os.chdir(Dir)
"""    
