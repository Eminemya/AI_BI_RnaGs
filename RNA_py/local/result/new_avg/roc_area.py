import os
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

Dir='/home/donglai/code/workspace/RNA_GS/RNA_py/local/test/new_avg/'
names=['en_roc_all','roc_1_all','roc_2_all']
for i in range(3):
    rb=[]
    print 'hahahahahhahahahahhaa'
    os.chdir(Dir+names[i])
    for ii in range(2,11):
        os.popen('python ch.py '+str(ii)+'.roc')
        a=os.popen('croc-area < '+str(ii)+'.roc_ch')
        c=a.readline()
        aa=open(str(ii)+'.roc_ch')
        bb=float(c[:-1])+rest_area(aa.readlines())
        aa.close()    
        rb.append(bb)
    os.chdir(Dir)
    for iii in range(9):
        print rb[iii]


