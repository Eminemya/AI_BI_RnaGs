import os
import sys
##################################################################################
#1) For B_GS_main.py

#1.1) Alignment Initialization with PROBCONS 
#Input:  seq_file
#Output: 00_aln
def Ini_aln(P_Dir,seq_file):
    if P_Dir[-1]!='/':
        P_Dir+='/'        
    tt=os.popen(P_Dir+'probcons '+seq_file+' >tmp.tmp')    
    sys.stdout.flush()    
    for line in tt.readlines(): 
        print line
    a=open('tmp.tmp')
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
    os.remove('tmp.tmp')

#1.2) Preparation for RNAlifold 
#Input:  00_aln
#Output: 0.aln
def Aln_aln(output,in_seq,seqs,num_seq):
    seq_read=open(in_seq,'r')
    seq_names=seq_read.readlines()
    seq_read.close()
    aln_write=open(output,'w')
    aln_write.write('CLUSTAL 2.0.12 multiple sequence alignment\n\n')
    alns=[None]*num_seq
    sum=[0]*num_seq            
    for i in range(0,num_seq):
        alns[i]=chop_seq(seqs[i+1][0:-1])
    for i in range(0,len(alns[0])):    
        for ii in range(0,num_seq):
            name=seq_names[ii*2][1:-1]
            sum[ii]+=count(alns[ii][i])
            aln_write.write(name+' '*(30-len(name))+alns[ii][i]+' '+str(sum[ii])+'\n')
        aln_write.write(' '*30+find_star([row[i] for row in alns],num_seq)+'\n\n')                                           
    aln_write.close()

def chop_seq(seq,length=50):
    return [seq[i:i+length] for i in range(0, len(seq), length)]
    
def find_star(aln,num_seq):
    star=''
    for i in range(0,len(aln[0])):
        tmp=0
        for ii in range(num_seq-1):
            #print ii
            if aln[ii][i]!=aln[ii+1][i]:
                tmp+=1
        if tmp==0 and aln[0][i]!='-' and aln[0][i]!='.':
            star+='*'
        else:
            star+=' '
    return star
                  
def count(aln):
    tmp=aln.strip()
    cc=0
    for i in range(0,len(tmp)):
        if tmp[i]!='.' and tmp[i]!='-':
            cc+=1 
    return cc

#1.3) Preparation for CM 
#Input: i.aln, RNAalifold output
#Output: i.sto
def Alifold_sto(read_aln,write_sto,stru,num_seq):
    aln =open(read_aln,'r')
    out_pu =open(write_sto,'w')
    seqq=['']*num_seq
    out_pu.write("# STOCKHOLM 1.0\n\n");
    aln.readline()
    reader=aln.readline()
    while len(reader.strip())==0:
        reader=aln.readline()        
    strus=chop_seq(stru[0:stru.rfind(' ')])
    chop_ind=0
    while reader!='' and reader[0]!=' ':
        for t in range(0,num_seq):
            sto_line=reader[0:reader.rfind(' ')]
            seqq[t]+=reader[30:reader.rfind(' ')]
            out_pu.write(sto_line+'\n')
            reader=aln.readline()     
        out_pu.write('#=GC SS_cons'+' '*18+strus[chop_ind]+'\n\n')
        chop_ind+=1
        reader=aln.readline()
        reader=aln.readline()                                      
    out_pu.write("//\n")
    out_pu.close()    
    aln.close()

    
#1.4) Preparation for RNAalifold
#Input: CM output
#Output: i.sto       
def CM_aln(to,stru,num_seq):
    i=0
    alns=num_seq*['']
    aln_write=open(to,'w')
    aln_write.write('CLUSTAL 2.0.12 multiple sequence alignment\n\n')        
    seqs=['']*num_seq
    len_seq=[0]*num_seq
    while '# STOCKHOLM' not in stru[i]:
        i+=1        
    else:
        i+=3
        while '#\n' not in stru[i]:
            for ii in range(0,num_seq):
                tmp=stru[i]
                seqs[ii]=tmp[tmp.rfind(' ')+1:-1]
                len_seq[ii]+=count(seqs[ii])
                aln_write.write(tmp[0:tmp.rfind(' ')]+' '*(30-tmp.rfind(' '))+tmp[tmp.rfind(' ')+1:-1]+' '+str(len_seq[ii])+'\n')                                       
                alns[ii]+=seqs[ii]
                i+=1
            i+=3
            aln_write.write(' '*30+find_star(seqs,num_seq)+'\n\n')
    aln_write.close() 
    return alns                

##################################################################################
#2) For Data Analysis
#2.1) Projecting the concensus structure onto each sequence
def project_strus(to,input_aln,input_str,ind_seq,num_seq):
    stru_write=open(to,'w')
    stru_read=open(input_str)
    stru=stru_read.readlines()
    stru_read.close()
    aln_read=open(input_aln)
    aln=aln_read.readlines()
    aln_read.close()
    N=len(stru)/2
    list=[[]]*N
    for i in range(N):
        out2=project(aln[(num_seq+1)*i+ind_seq][0:-1],stru[1+2*i].strip())        
        list[i]=bra2list(out2)
        stru_write.write('>Structrue '+str(i)+'\n')
        stru_write.write(out2+'\n')            
    stru_write.close()
    return list

def project(in_aln,in_str):
    tt=[1]*len(in_aln)
    output=in_str
    indent=[]
    for ii in range(0,len(in_aln)):
        if in_aln[ii]=='-' or in_aln[ii]=='.':
            indent.append(ii)
            tt[ii]='0'
    while indent:
        if output[indent[0]]!='.':
            if in_str[indent[0]]=='(' or in_str[indent[0]]=='<':
                left=1
                right=0
                step=1
            else:
                left=0
                right=1   
                step=-1
            count=indent[0]
            output=output[:count] +'.'+ output[count+1:]
            while left!=right:
                count=count+step
                if in_str[count]=='(' or in_str[count]=='<':
                    left=left+1
                elif in_str[count]==')' or in_str[count]=='>':
                    right=right+1;
            output=output[:count] +'.'+ output[count+1:]
        del indent[0]
    out2=''
    for ww in range(len(output)):
        if tt[ww]==1:
            out2+=output[ww]
    return out2    

#2.2) Structure->index of nonzero entries in the Binary Matrix
def bra2list(bracket):
    N=len(bracket)
    list=[]
    topstack = -1
    openstack = []    
    for i in range(N):
        if bracket[i]=='(':
            topstack+=1
            openstack.append(i) 
        elif bracket[i]==')':
            list.append(openstack[topstack]*N+i) 
            del openstack[topstack]
            topstack = topstack-1
    return list
                                       
def bratrans(tt):
    truth=''
    if(tt[len(tt)-1]=='\n'):
        tt=tt[:-1]
    for i in range(len(tt)):
        if(tt[i]=='<'):
            truth+='('
        elif(tt[i]=='>'):
            truth+=')'
        else:
            truth+='.'
    return truth

#2.3) SEN,PPV calculation 
def sta(stru,true,N=1):
    TP=0
    for i in range(len(stru)):
        TP+=isthere(true,stru[i])
    #print TP,len(stru),len(true)
    SEN=float(TP)/(float(len(true)))
    if len(stru)==0:
        PPV=0
    else:
        PPV=float(TP)/(float(len(stru)))    
    #FP=len(stru)-TP
    #FN=len(true)-TP;
    #TN=N*(N-1)/2-len(true)-FP
    #TPR=float(TP)/(float(TP+FN))
    #PPV=float(TP)/(float(TP+FP))
    #FPR=FP/(FP+TN)
    sta=[PPV,SEN]
    return sta

def isthere(listt,num):
    yes=0
    for i in listt:
        if(i==num):
            yes=1
            break
    return yes

#2.4) ROC calculation     
def cal_roc(Dir,num_seq):
    if Dir[-1]!='/':
        Dir+='/'
    for i in range(num_seq):    
        truth=open(Dir+'tru_str_'+str(i+1),'r')
        true=truth.readline()
        truth.close()
        roc1=open(Dir+'roc_'+str(i+1),'w')
        r1=open(Dir+'centroid_'+str(i+1),'r')    
        roc2=open(Dir+'en_roc_'+str(i+1),'w')
        r2=open(Dir+'en_centroid_'+str(i+1),'r')    
        reader=r1.readline()
        while reader:    
            for ii in range(17):
                reader=r1.readline()
                re=sta(bra2list(reader[:reader.find('g')]),bra2list(true))
                roc1.write(str(re[0])+','+str(re[1])+'\n')
            reader=r1.readline()                           
        reader=r2.readline()
        while reader:    
            for ii in range(17):
                reader=r2.readline()
                re=sta(bra2list(reader[:reader.find('g')]),bra2list(true))
                roc2.write(str(re[0])+','+str(re[1])+'\n')
            reader=r2.readline()                               
        r2.close()
        r1.close()
        roc2.close()
        roc1.close()
#naively interpolate the area out of the range of the ROC curve
def rest_area(rr):
    tmp=rr[0]
    now_2=float(tmp[tmp.find(' ')+1:-1])
    now_1=float(tmp[:tmp.find(' ')])
    area=now_1*now_2/2    
    tmp=rr[16]
    now_2=float(tmp[tmp.find(' ')+1:-1])
    now_1=float(tmp[:tmp.find(' ')])
    area+=(1-now_1)*(1+now_2)/2    
    return area
        
