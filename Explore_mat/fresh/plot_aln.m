function y=plot_aln(true)

aln_mat=[];
in_1=find(true(1,:));
in_2=find(true(2,:)==0);

for i=1:length(in_1)
    if(true(2,in_1(i))~=0)
    tmp=length(find(in_2<in_1(i)));
    aln_mat=[aln_mat;[i,in_1(i)-tmp]];
    end
end
figure
plot(aln_mat(:,1),aln_mat(:,2),'b.')

end