%3 bifur
%aln dependent
qqq=1;
haha=cell(1);
for i=1:2000
haha2=tmp_al{(ww+2)*(i-1)+2+qqq};
ind=find(haha2~='.');
haha2=haha2(ind);
haha{i}=tmp_st{3*i}(ind);
ind=find(haha2~='-');
haha{i}=haha{i}(ind);
bifur{i}=find_bifur(haha{i});
end
len=cellfun(@length,bifur);
figure
hold on
colors=['b.';'g.';'r.';'m.';'y.';'k.'];
for i=1:2000
    for j=1:length(bifur{i})
    plot(bifur{i}(j,1),bifur{i}(j,2),colors(mod(i,6)+1,:))
end
end


% dist matrix(cross)

num=2000;
matrix_1=zeros(num,num);
for i=1:num
    i
    for j=i+1:num
        matrix_1(i,j)=constraint_new(bifur{i},bifur{j});
    end;
end;
matrix_1=matrix_1+matrix_1';

cluster=zeros(1,2000);
cluster(1)=1;
cluster_num=1;
aaaa=matrix_1;
for i=2:2000
    t=ones(1,cluster_num);
    for j=1:cluster_num
        members=find(cluster==j);
        for k=1:length(members)
        if(aaaa(i,members(k))~=0)
                t(1,j)=0;
           break;
            end
        end
    end
    if(sum(t)~=0)
    %uniform sampling....
    cluster(i)=find(t==1,1);
    else
        %new cluster
        cluster_num=cluster_num+1;
        cluster(i)=cluster_num;
    end
end
for i=1:cluster_num
T(i)=length(find(cluster==i));
end




rnaplot(haha,'Format','circle')
rnaplot(constr{3},'Format','circle')
rnaplot(tmp_st{3*100},'Sequence',tmp_al{12*99+3},'Format','diagram')

