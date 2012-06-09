import os
import shutil
Dir='/home/donglai/Desktop/RNA/roc_seq/'
#names=['probcons']
names=['0.aln','00aln']
"""
names=['exitcmd.txt','Gibb2.jpg','mfestr','para4.pbs','para9.pbs',
'project_2.str','seq.fa','gcen_roc_1',' hier_clus.m ',
'para0.pbs','para5.pbs','  para.pbs ','      re_cen.py',
' stu_1.mat','0.aln',' gcen_roc_2 ',' hier.pbs   ','   para1.pbs ',' para6.pbs ',
' para.pbs.out ','  roc1.jpg   ',
' stu_2.mat',' g_centroid_1 ',' hoho.pbs.out ',' para2.pbs ',
' para7.pbs ','  roc_plot.m  ','   test.py  ','centroid_2 ',
' Gibb1.jpg  ','   init.m  ','      para3.pbs ',' para8.pbs ',
'project_1.str ',' roc.py   ','      tree1.jpg ']
"""

num_folder=85
#num_folder=1
for i in range(num_folder):
    tmp_Dir=Dir+str(i)+'/'
    os.chdir(tmp_Dir)
    for ii in range(3,11):    
        tmp_Dir+=str(ii)+'/'
        os.chdir(tmp_Dir)
        for name in names:
            #shutil.copy(name,tmp_Dir)        
            if os.path.exists(tmp_Dir+name.strip()):
                os.remove(name.strip())
        """"""
    """
    for ii in [2,5,7]:
        os.chdir(tmp_Dir+str(ii)+'_sub/')
        for name in names:
            if os.path.exists(tmp_Dir+str(ii)+'_sub/'+name):
                os.remove(name)
        os.chdir(tmp_Dir)
    os.chdir(Dir)    
    """

