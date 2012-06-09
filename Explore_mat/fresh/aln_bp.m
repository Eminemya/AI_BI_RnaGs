function aln_mat=aln_bp(aln)
aln_mat=[];
ind1=find(aln{1}=='-');
ind2=find(aln{2}=='-');
true=ones(2,length(aln{1}));
true(1,ind1)=0;
true(2,ind2)=0;
in_1=find(true(1,:));
in_2=find(true(2,:)==0);

for i=1:length(in_1)
    if(true(2,in_1(i))~=0)
    tmp=length(find(in_2<in_1(i)));
    aln_mat=[aln_mat;[i,in_1(i)-tmp]];
    end
end
