seq='AACUUAUCAAGAGAAGUGGAGGGACUGGCCCAAAGAAGCUUCGGCAACAUUGUAUCAUGUGCCAAUUCCAGUAACCGAGAAGGUUAGAAGAUAAGGU'
rnaplot(a,'sequence',seq,'format','diagram');




bias=zeros(2,20);
sstd=zeros(2,20);
clnos=load('clusnum');
Dir='/home/donglai/code/workspace/RNA_GS/RNA_py/local/roc_norm_mul/ribo_';
iter=1;
for ii=1:5
tmp_Dir=[Dir num2str(ii) '/'];
eval(['cd ' tmp_Dir])
load 'stu_1.mat'
cl_no=clnos(iter);
cl= cluster(Z,'maxclust',cl_no);
T=zeros(1,cl_no);
for j=1:cl_no
T(j)=sum(cl==j);
end
[ord,oo]=sort(T,'descend');
tmp_cl=zeros(1,1000);
for j=1:cl_no
tmp_cl(cl==oo(j))=j;
end
cl=tmp_cl;
bias(1,iter)=mean(dis(1000+find(cl==1)));
bias(2,iter)=mean(dis(1000+find(cl==2)));
sstd(1,iter)=std(dis(1000+find(cl==1)));
sstd(2,iter)=std(dis(1000+find(cl==2)));
iter=iter+1;

for i=[5,7,10]
tmp_Dir=[tmp_Dir num2str(i) '/']
eval(['cd ' tmp_Dir])
load 'stu_1.mat'
cl_no=clnos(iter);
cl= cluster(Z,'maxclust',cl_no);
T=zeros(1,cl_no);
for j=1:cl_no
T(j)=sum(cl==j);
end
[ord,oo]=sort(T,'descend');
tmp_cl=zeros(1,1000);
for j=1:cl_no
tmp_cl(cl==oo(j))=j;
end
cl=tmp_cl;
bias(1,iter)=mean(dis(1000+find(cl==1)));
bias(2,iter)=mean(dis(1000+find(cl==2)));
sstd(1,iter)=std(dis(1000+find(cl==1)));
sstd(2,iter)=std(dis(1000+find(cl==2)));
iter=iter+1;
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%distance from centroid to mfe
mfe=textread('mfe','%s');
mfe=rnaconvert(mfe{1});
mfe=rnaconvert('((((((((......(((...(((.....)))......)))..(((.(((........))))))........((((.......))))...))))))))');
bias=zeros(2,20);

Dir='/home/donglai/code/workspace/RNA_GS/RNA_py/local/roc_norm_mul/ribo_';
iter=1;
for ii=1:5
tmp_Dir=[Dir num2str(ii) '/'];
eval(['cd ' tmp_Dir])
a=textread('centroid_1','%s')
c1=rnaconvert(a{9}(1:97));
c2=rnaconvert(a{29}(1:97));
bias(1,iter)=sum(sum(abs(c1-mfe)));
bias(2,iter)=sum(sum(abs(c2-mfe)));
iter=iter+1;
for i=[5,7,10]
tmp_Dir=[tmp_Dir num2str(i) '/']
eval(['cd ' tmp_Dir])
a=textread('centroid_1','%s')
c1=rnaconvert(a{9}(1:97));
c2=rnaconvert(a{29}(1:97));
bias(1,iter)=sum(sum(abs(c1-mfe)));
bias(2,iter)=sum(sum(abs(c2-mfe)));
iter=iter+1;

end
end








