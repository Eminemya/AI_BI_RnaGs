import os
import shutil
num_folder=85
Dir='/users/dwei/roc_seq/'

def write_pbs(command,name):
    a=open(name,'w')
    a.write(
"""#PBS -N test
#PBS -r n
#PBS -o ./hoho.pbs.out
#PBS -j oe
#PBS -l cput=240:00:00
#PBS -l nodes=1:ppn=1
#PBS -l walltime=240:00:00
#PBS -V
cd $PBS_O_WORKDIR
echo Master process running on `hostname`
echo Directory is `pwd`
echo PBS has allocated the following nodes:
echo `cat $PBS_NODEFILE`
echo Starting execution at `date`
cd $PBS_O_WORKDIR
set NPROCS=`wc -l < $PBS_NODEFILE`
echo This job has allocated $NPROCS CPUs
"""+command+"""
echo Finished execution at `date`
""")
    a.close()

names=['roc.py']
#names=['project.py']
#names=['GS_seq.py']
#names=['con.py']
#names=['test.py']
#names=['hier_clus.m']
#names=['test_h.py']
#command='matlab -r "en_cen"'
#command='python project.py'
#command='python con.py'
#command='python test.py'
#command='matlab -r "hier_clus('
#command='python GS_seq.py'
command='python roc.py '

order=range(85)
for i in order:
    tmp_Dir=Dir+str(i)+'/'
    for name in names:
        shutil.copy(name,tmp_Dir)    
    os.chdir(tmp_Dir)
    #write_pbs(command+str(2)+')"',tmp_Dir+'para.pbs')    
    write_pbs(command+str(2),tmp_Dir+'para.pbs')
    os.popen('qsub para.pbs')                       
    for ii in range(3,11):
        #print ii
        tmp_Dir+=str(ii)+'/'
        for name in names:
            shutil.copy(name,tmp_Dir)    
        os.chdir(tmp_Dir)
        print os.getcwd()
        write_pbs(command+str(ii),tmp_Dir+'para.pbs')
        os.popen('qsub para.pbs')
