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

Dir='/home/donglai/code/workspace/RNA_GS/RNA_py/local/test/Fam17/'
names=['rocc','roc-1','roc-2']
namess=['en_roc_fam_','roc_1_fam_','roc_2_fam_']
order=[11,17,1,2,6,13,14,16,4,5,10,12,3,7,15,8,9];
for i in range(3):
    rb=[]
    print 'hahahahahhahahahahhaa'
    os.chdir(Dir+names[i])
    for ii in range(1,18):
        os.popen('python ch.py '+namess[i]+str(ii))
        a=os.popen('croc-area < '+namess[i]+str(ii)+'_ch')
        c=a.readline()
        aa=open(namess[i]+str(ii)+'_ch')
        bb=float(c[:-1])+rest_area(aa.readlines())
        aa.close()    
        rb.append(bb)
    os.chdir(Dir)
    for iii in range(17):
        print rb[order[iii]-1]
