import os
import shutil
#import roc                      
#import project
from sub import *

num_seq=10
num_folder=85
p_Dir="/home/donglai/code/workspace/RNA_GS/RNA_py/local/script/"
Dir='/home/donglai/code/workspace/RNA_GS/RNA_py/local/roc_10_'
"""
for i in range(1,10):    
    for j in range(0,85):
        tmp_Dir=Dir+str(i)+'/'+str(j)+'/'    
        for ii in range(3,11):
            os.chdir(tmp_Dir)
            desti=tmp_Dir+str(ii)+'/'
            for iii in range(1,11):
                shutil.copy('tru_str_'+str(iii),desti)
            ran_sub(p_Dir+'probcons',tmp_Dir,ii-1)
            tmp_Dir=desti        

"""
order=range(1,num_folder)
order=[0]
Dir2='/home/donglai/code/workspace/RNA_GS/RNA_py/local/3_roc'
os.chdir(Dir2)
for i in order:
    tmp_Dir=Dir+str(i)+'/'
    if not os.path.exists(str(i)):
        os.mkdir(str(i))    
    shutil.copy(Dir+'0/'+str(i)+'/3/4/5/6/7/8/9/10/00aln','./'+str(i)+'/')
    shutil.copy(Dir+'0/'+str(i)+'/3/4/5/6/7/8/9/10/seq_10.fa','./'+str(i)+'/')
    #os.chdir(tmp_Dir)
    #project.project(tmp_Dir,2)           
    #sub(Dir+'probcons',tmp_Dir)

