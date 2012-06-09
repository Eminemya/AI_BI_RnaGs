haha=zeros(1,17);
for i=1:17
a=load(['en_roc_fam_',num2str(i)]);  
b=roca(a(1:17,:));
a=load(['roc_1_fam_',num2str(i)]);  
c=roca(a(1:17,:));
a=load(['roc_2_fam_',num2str(i)]);  
d=roca(a(1:17,:));
haha(i)=max([b,c,d]);
end    
