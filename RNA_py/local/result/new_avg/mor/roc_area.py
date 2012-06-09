import os
import sys
ww=[]
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

Dir='/home/donglai/code/workspace/RNA_GS/RNA_py/local/test/new_avg/mor/'
names=['en_roc_m','roc_1_m','roc_2_m']

for i in range(3):
    aaa=[]
    print 'hahahahahhahahahahhaa'
    os.chdir(Dir+names[i])
    for ii in range(2,11):
        os.popen('python ch.py '+str(ii)+'.roc')
        a=os.popen('croc-area < '+str(ii)+'.roc_ch')
        c=a.readline()
        aa=open(str(ii)+'.roc_ch')
        bb=float(c[:-1])+rest_area(aa.readlines())
        aaa.append(bb)
        aa.close()    
    os.chdir(Dir)
    print aaa
