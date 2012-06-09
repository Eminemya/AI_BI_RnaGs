import os
import sys
sys.path.append('../')
from B_GS_main import *
from kiryu_util import *

Dir=os.getcwd()+'/'
num_seq=10
order=range(3)
subalign=[2,5,7,10]
os.chdir(Dir)
R_Dir=''
C_Dir=''
P_Dir=Dir[:Dir.rfind('/')]+'/'
#1) parse kiryu data:
num_folder=parse_data('dataset1_stockholm.txt',num_seq,range(10))
#order=range(num_folder)

#the initialization in B_GS does not create such hierarchy for multiple sequences
#2) Probcons Alignment Initialization:
for i in [0,1]:
    tmp_Dir=Dir+str(i)+'/'
    os.chdir(tmp_Dir)
    sub(P_Dir+'probcons',tmp_Dir,subalign)

#3) Collapsed Gibbs Sampling
iteration=1
os.chdir(Dir)
for ii in [0,1]:
    tmp_Dir=Dir+str(ii)+'/'
    os.chdir(tmp_Dir)
    for i in subalign:
        tmp_Dir+=str(i)+'/'    
        os.chdir(tmp_Dir)    
        seq_file=tmp_Dir+'seq_'+str(i)+'.fa'
        B_GS(seq_file,R_Dir,C_Dir,iteration)
