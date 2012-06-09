
for ii=2:5
cd '/home/donglai/code/workspace/RNA_GS/RNA_py/local/roc_norm_mul/'
Dir=['/home/donglai/code/workspace/RNA_GS/RNA_py/local/roc_norm_mul/ribo_',num2str(ii)];
hier_clus(Dir,2,1000)
Dir=[Dir '/5'];
cd '/home/donglai/code/workspace/RNA_GS/RNA_py/local/roc_norm_mul/'
hier_clus(Dir,5,1000)
Dir=[Dir '/7'];
cd '/home/donglai/code/workspace/RNA_GS/RNA_py/local/roc_norm_mul/'
hier_clus(Dir,7,1000)
cd '/home/donglai/code/workspace/RNA_GS/RNA_py/local/roc_norm_mul/'
Dir=[Dir '/10'];
hier_clus(Dir,10,1000)
end
