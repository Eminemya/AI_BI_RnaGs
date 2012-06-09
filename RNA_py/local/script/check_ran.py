import os
import sys
Dir='/home/donglai/code/workspace/RNA_GS/RNA_py/local/roc_10_'
ll=[]
for i in range(1,10):
    for ii in range(85):
       tmp_Dir=Dir+str(i)+'/'+str(ii)+'/'
       os.chdir(tmp_Dir)
       if os.path.exists('0.aln'):
           os.remove('0.aln')
       if os.path.exists('00aln'):
           os.remove('00aln')
       if os.path.exists('seq_2.fa'):
           a=1
           #os.remove('seq_2.fa')
       else:
           ll.append(i)   
           ll.append(ii)
           ll.append(2)           
       for iii in range(3,11):
           tmp_Dir+=str(iii)+'/'
           os.chdir(tmp_Dir)
           if os.path.exists('0.aln'):
               os.remove('0.aln')
           if os.path.exists('00aln'):
               os.remove('00aln')
           if os.path.exists('seq_'+str(iii)+'.fa'):
               a=1
               #os.remove('seq_'+str(iii)+'.fa')
           else:
               ll.append(i)   
               ll.append(ii)
               ll.append(iii)

           
