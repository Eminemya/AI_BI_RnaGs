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
    
def rest_area_inter(rr):
    #line interpolate endpts
    tmp=rr[0]
    now_2=float(tmp[tmp.find(' ')+1:-1])
    now_1=float(tmp[:tmp.find(' ')])
    next_2=now_2
    next_1=now_1
    iter=1
    #print now_2,now_1
    while next_1==now_1 and next_2==now_2:   
        tmp=rr[iter]
        next_2=float(tmp[tmp.find(' ')+1:-1])
        next_1=float(tmp[:tmp.find(' ')])
        iter+=1
        print iter,next_2,next_1
    if next_1!=now_1:
        tt=(-1)*now_1*(next_2-now_2)/(next_1-now_1)+now_2
        if tt>=0:
            area=now_1*(tt+now_2)/2    
        else:
            area=(now_1-now_2*(next_1-now_1)/(next_2-now_2))*(now_2)/2
    else:
        area=0                            
    tmp=rr[16]    
    next_2=float(tmp[tmp.find(' ')+1:-1])
    next_1=float(tmp[:tmp.find(' ')])
    iter=15
    now_2=next_2
    now_1=next_1
    while next_1==now_1 and next_2==now_2:   
        tmp=rr[iter]    
        now_2=float(tmp[tmp.find(' ')+1:-1])
        now_1=float(tmp[:tmp.find(' ')])
        iter-=1
    print iter,now_2,now_1    
    if next_1!=now_1:
        tt=(1-now_1)*(next_2-now_2)/(next_1-now_1)+now_2
        if tt<=1:
            area+=(1-next_1)*(tt+next_2)/2    
        else:
            tmp=now_1+(1-now_2)*(next_1-now_1)/(next_2-now_2)
            area+=1-tmp+(tmp-next_1)*(1+next_2)/2        
    else:
        area+=1-now_1
     
    return area
    
rb=[]
rc=[]
rd=[]
for i in range(1,18):
    print i
    #os.popen('python ch.py en_roc_fam_'+str(i))
    a=os.popen('croc-area < en_roc_fam_'+str(i)+'_ch')
    c=a.readline()
    aa=open('en_roc_fam_'+str(i)+'_ch')
    bb=float(c[:-1])+rest_area(aa.readlines())
    aa.close()    
    rb.append(bb)
    os.popen('python ch.py roc_1_fam_'+str(i))
    a=os.popen('croc-area < roc_1_fam_'+str(i)+'_ch')
    c=a.readline()
    aa=open('roc_1_fam_'+str(i)+'_ch')
    bb=float(c[:-1])+rest_area(aa.readlines())
    aa.close()    
    rc.append(bb)
    os.popen('python ch.py roc_2_fam_'+str(i))
    a=os.popen('croc-area < roc_2_fam_'+str(i)+'_ch')
    c=a.readline()
    aa=open('roc_2_fam_'+str(i)+'_ch')
    bb=float(c[:-1])+rest_area(aa.readlines())
    aa.close()    
    rd.append(bb)

order=[11,17,1,2,6,13,14,16,4,5,10,12,3,7,15,8,9]
for i in range(17):
    print rb[order[i]-1]
for i in range(17):
    print rc[order[i]-1]
for i in range(17):
    print rd[order[i]-1]
