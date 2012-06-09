import sys
ff= sys.argv[1]
b=open(ff,'r')
a=b.readlines()
c=open(ff+'_ch','w')

def trm(tmp,pre_1,pre_2):
    now_1=1-float(tmp[tmp.find(',')+1:-1])
    now_2=float(tmp[:tmp.find(',')])    
    if now_1<pre_1:
        now_1=pre_1
    if now_2<pre_2:
        now_2=pre_2       
    return [now_1,now_2] 

tmp=a[0]
pre_1=1-float(tmp[tmp.find(',')+1:-1])
pre_2=float(tmp[:tmp.find(',')])
c.write(str(pre_1)+' '+str(pre_2)+'\n')
for i in range(1,8):
    tmp=a[i]
    [now_1,now_2]=trm(tmp,pre_1,pre_2)
    c.write(str(now_1)+' '+str(now_2)+'\n')
    pre_1=now_1
    pre_2=now_2

tmp=a[16]
[now_1,now_2]=trm(tmp,pre_1,pre_2)
c.write(str(now_1)+' '+str(now_2)+'\n')
pre_1=now_1
pre_2=now_2
for i in range(8,16):
    tmp=a[i]
    [now_1,now_2]=trm(tmp,pre_1,pre_2)
    c.write(str(now_1)+' '+str(now_2)+'\n')
    pre_1=now_1
    pre_2=now_2
