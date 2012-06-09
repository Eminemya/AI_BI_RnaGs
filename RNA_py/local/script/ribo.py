import os
def ham_dis(str1,str2):
    dis=0;
    for i in range(len(str1)):
        if str1[i]!=str2[i]:
            dis+=1
    return dis        

def find_clno(infile):
    cl_num=1
    num=[]
    f=open(infile,'r')
    reader=f.readline()
    num.append(int(reader[reader.find(':(')+2:reader.find(')')]))
    while reader:
        reader=f.readline()
        if '>>' in reader:
            num.append(int(reader[reader.find(':(')+2:reader.find(')')]))
            cl_num+=1
    f.close()
    num.sort()
    re=[cl_num,num[cl_num-1],num[cl_num-2]]
    return re
    
    
      
#1)cluster numbers
Dir='/home/donglai/code/workspace/RNA_GS/RNA_py/local/roc_norm_mul/ribo_'

#clus_num=open('/home/donglai/code/workspace/RNA_GS/RNA_py/local/roc_norm_mul/clusnum','w')
#cl_num=[0,0,0,0]
cl_num=[]
cl_1=[]
cl_2=[]
#cl_1=[0,0,0,0]
#cl_2=[0,0,0,0]
for i in range(1,6):
    tmp_Dir=Dir+str(i)+'/'
    os.chdir(tmp_Dir)
    re=find_clno('centroid_1')
    cl_num.append(str(re[0])+',')
    cl_1.append(str(re[1])+',')
    cl_2.append(str(re[2])+',')
    #cl_num[0]+=re[0]
    #cl_1[0]+=re[1]
    #cl_2[0]+=re[2]
    iteri=1
    for ii in [5,7,10]:
        tmp_Dir+=str(ii)+'/'
        os.chdir(tmp_Dir)
        re=find_clno('centroid_1')
        cl_num.append(str(re[0])+',')
        cl_1.append(str(re[1])+',')
        cl_2.append(str(re[2])+',')
        #cl_num[iteri]+=re[0]
        #cl_1[iteri]+=re[1]
        #cl_2[iteri]+=re[2]
        iteri+=1

        
clus_num.write(''.join(cl_num)+'\n')
clus_num.close()

 

    
    
    
    
    
    
