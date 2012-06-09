import sys
ff= sys.argv[1]
b=open(ff,'r')
a=b.readlines()
c=open(ff+'_ch','w')
for i in range(8):
    tmp=a[i]
    c.write(str(1-float(tmp[tmp.find(',')+1:-1]))+' '+tmp[:tmp.find(',')]+'\n')
tmp=a[16]
c.write(str(1-float(tmp[tmp.find(',')+1:-1]))+' '+tmp[:tmp.find(',')]+'\n')
for i in range(8,16):
    tmp=a[i]
    c.write(str(1-float(tmp[tmp.find(',')+1:-1]))+' '+tmp[:tmp.find(',')]+'\n')

        
        


