#-1) Needed for the test: 
#Original Sequence: seq.fa
#Reference Structure: tru_str_1, tru_str_2
#Initial Alignment: 00aln

import os
import sys
current=os.getcwd()
#back to main functions
Dir=current[:current.rfind('/')+1]
sys.path.append(Dir)
from B_GS_main import *
from B_GS_util import *

#0)setting parameters
seq_file=current+'/seq.fa'
R_Dir=''#directory of RNAlifold
C_Dir=''#directory of CM
iteration=10
P_Dir=0#directory of PROBCONS
num_seq=2
#1)Blocked Gibbs Sampling
B_GS(seq_file,R_Dir,C_Dir,iteration,P_Dir)
#2)Hierarchical Clustering+find Centroid+Bias-Variance
os.chdir(Dir)
exit=open('exit_cmd','w')
exit.write('exit')
exit.close()
os.popen("""matlab -r "hier_clus('"""+current+"""/',2,5,5)\" -nodesktop -nojvm -nosplash <exit_cmd""")
os.remove('exit_cmd')
#3)Find ROC for 17 gamma-centroid
cal_roc(current,num_seq)
print "This is a MAN, not a boy!!!"
