function y=hier_clus(Dir_data,num_seq,burn_in,iter)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
if(Dir_data(end)~='/')
Dir_data=[Dir_data,'/'];
end
eval(['cd ' Dir_data])
set(0,'RecursionLimit',1000000)

for ind_seq=1:num_seq
truth=textread(['tru_str_',num2str(ind_seq)],'%s');
truth=truth{1};
N=length(truth);
%1)transform from bracket to binary matrix
tmp_st=textread(['project_',num2str(ind_seq),'.str'],'%s');
stru=cell(1,1+iter+burn_in);
stru{1}=bra2list(truth);
for i=1:iter+burn_in
stru{i+1}=bra2list(tmp_st{3*i});
end
iteration=length(tmp_st)/3;
data=iteration-burn_in;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%2)distance from the reference structure
dis=find_same(stru,2);
%bias-variance
dlmwrite([Dir_data,'bias_variance'],['>> sequence ', num2str(ind_seq), ': '],'delimiter','','-append')
dlmwrite([Dir_data,'bias_variance'],['Bias: ',num2str(mean(dis(burn_in+1:end)))],'delimiter','','-append')
dlmwrite([Dir_data,'bias_variance'],['Variance: ',num2str(var(dis(burn_in+1:end)))],'delimiter','','-append')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%3)Hierarchical Clustering
%burn in the first burn_in
dis2=find_same(stru(burn_in+2:end),1);
Z = linkage(squareform(dis2,'tovector'),'average');
%c=dendrogram(Z);
%title('Linkage average')
%saveas(gcf,['tree',num2str(ind_seq),'.jpg']); 
%close;
dstnme=sprintf('stu_%d.mat',ind_seq);  
eval(['save ',dstnme,' stru dis2 Z dis']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%4)CH-index to determine number of clusters 2:20
%dstnme=sprintf('stu_%d.mat',ind_seq);  
%eval(['load ',dstnme]);
best=-1;
for i=2:20
tmp_cl= cluster(Z,'maxclust',i); 
enen=zeros(1,N^2);
pp=cell(1,i);
W=0;
for ii=1:i
centroid=zeros(1,N^2);
cl_ind=find(tmp_cl==ii);
len=length(cl_ind);
for iii=cl_ind'
centroid(stru{burn_in+1+iii})=centroid(stru{burn_in+1+iii})+1;
end
enen=enen+centroid;
centroid=centroid/len;
[str,pair]=find_cen(centroid,N,1);
pp{ii}=pair';
tmp=find_same({pair',stru{burn_in+1+cl_ind}},2);
W=W+sum(tmp.^2);
end
len=data;
centroid=enen/len;
[str,pair]=find_cen(centroid,N,1);
tmp=find_same([pair',pp],2);
B=sum(tmp.^2);
tmp_best=B*(data-i)/((i-1)*W);
if(best<tmp_best)
cl=tmp_cl;
cl_no=i;
best=tmp_best;
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%5)multiple centroid and 95 credibility limit
%sort it a little bit
T=zeros(1,cl_no);
for i=1:cl_no
T(i)=sum(cl==i);
end
[ord,oo]=sort(T,'descend');
tmp_cl=zeros(1,data);
for i=1:cl_no
tmp_cl(cl==oo(i))=i;
end
cl=tmp_cl;
enen=zeros(1,N^2);
for i=1:cl_no
centroid=zeros(1,N^2);
cl_ind=find(tmp_cl==i);
len=length(cl_ind);
for iii=cl_ind
centroid(stru{burn_in+1+iii})=centroid(stru{burn_in+1+iii})+1;
end
enen=enen+centroid;
centroid=centroid/len;
dlmwrite(['centroid_',num2str(ind_seq)],['>>centroid ',num2str(i),' :(',num2str(len),')'],'delimiter','','-append')
for gamma=[2.^[-5:1:10],6]
[str,pair]=find_cen(centroid,N,gamma);
tmp_dis=sort(find_same({pair',stru{burn_in+1+cl_ind}},2),'ascend');
wrt=['g=',num2str(gamma),',CL_95:',num2str(tmp_dis(ceil(.95*len)))];
dlmwrite(['centroid_',num2str(ind_seq)],[str,wrt],'delimiter','','-append')
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%6)ensemble centroid and 95 credibility limit

len=data;
centroid=enen/len;
dlmwrite(['en_centroid_',num2str(ind_seq)],['>>centroid ',num2str(1),' :(',num2str(len),')'],'delimiter','','-append')
for gamma=[2.^[-5:1:10],6]
[str,pair]=find_cen(centroid,N,gamma);
tmp_dis=sort(find_same({pair',stru{burn_in+1+(1:len)}},2),'ascend');
wrt=['g=',num2str(gamma),',CL_95:',num2str(tmp_dis(ceil(.95*len)))];
dlmwrite(['en_centroid_',num2str(ind_seq)],[str,wrt],'delimiter','','-append')
end
end

end


function ch_ind=ch(num_cl,diss,cluster,T)
%total sum of squares T
%diss=dis2.^2;
%T=sum(sum(diss));
%sum of squares within each cluster W
W=0;
for i=1:num_cl
ind=find(cluster==i);
W=W+sum(sum(diss(ind,ind)));
end
B=T-W;
ch_ind=B*(size(diss,1)-num_cl)/((num_cl-1)*W);
end


function y=bra2list(bracket)
topstack = 0;
openstack = [];
y=[];
N=length(bracket);
for i=1:N
    if (bracket(i)=='(')
        topstack = topstack + 1;
        openstack(topstack) = i; 
    elseif (bracket(i)==')')
        y=[y,openstack(topstack)*N+i];
        topstack = topstack-1;
    end
end
end


function y=find_same(stru,mode)
if(mode==1)
%dist matrix
y=zeros(length(stru));
for i=1:length(stru)
    for j=i+1:length(stru)        
        y(i,j)=dist_ham(stru{i},stru{j});
    end
end
y=y+y';
elseif(mode==2)
y=zeros(1,length(stru)-1);
for i=2:length(stru)
y(i-1)=dist_ham(stru{1},stru{i});
end
end
end

function y=dist_ham(t1,t2)
he=unique([t1,t2]);
y=2*length(he)-length(t1)-length(t2);
end

function [str,pair]=find_cen(pij,N,gamma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% gamma~[0,1]:direct
if(gamma<=1)
str=repmat('.',1,N);
pair=[];
for ii=find(pij>1/(1+gamma))
po1=floor(ii/N);
po2=ii-N*po1;
if(po2==0)
po1=po1-1;
po2=N;
end
str(po1)='(';
str(po2)=')';
pair=[pair;ii];
end

else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% gamma~[1,...]:DP
%1) Recursion:
DP=zeros(N);
for L=2:N
for i=1:N+1-L
j=i+L-1;
DP(i,j)=max([DP(i+1,j),DP(i,j-1),DP(i+1,j-1)+(1+gamma)*pij(i*N+j)-1,DP(i,[i+1:j-1])+DP(1+[i+1:j-1],j)']);
end
end
%2) Backtrack:
stack=[1,N];
pair=[];
while ~isempty(stack)
i=stack(1);
j=stack(2);
stack=stack(3:end);
if(i<j)
  if(DP(i+1,j)==DP(i,j))
	stack=[stack,i+1,j];
  elseif(DP(i,j-1)==DP(i,j))
	stack=[stack,i,j-1];
  elseif(DP(i+1,j-1)+(1+gamma)*pij(i*N+j)-1==DP(i,j))
	stack=[stack,i+1,j-1];
	pair=[pair;[i,j]];
  else
	for k=i+1:j-1
	  if(DP(i,k)+DP(1+k,j)==DP(i,j))
	  stack=[stack,k+1,j,i,k];
	  break;
	  end
	end
  end
end
end
%3) return:
str=repmat('.',1,N);
if(~isempty(pair))
str(pair(:,1))='(';
str(pair(:,2))=')';
pair=pair(:,1)*N+pair(:,2);
end
end
end
