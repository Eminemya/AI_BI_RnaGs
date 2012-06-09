function y=seq_stru(place,ww)
cd(place);
tmp_al=textread('00aln.file','%s');
tmp_st=textread('00stru.file','%s');
haha=cell(1,2000);
for i=1:2000
haha2=tmp_al{(ww+2)*(i-1)+3};
ind=find(haha2=='.');
haha{i}=tmp_st{3*i};
indent=[ind,find(haha2=='-')];
tt=ones(1,length(haha2));
tt(indent)=0;
while(~isempty(indent))
    if(haha{i}(indent(1))~='.')
if(tmp_st{3*i}(indent(1))=='(')
left=1;
right=0;
step=1;
else
left=0;
right=1;   
step=-1;
end
count=indent(1);
haha{i}(count)='.';
while(left~=right)
count=count+step;
if(tmp_st{3*i}(count)=='(')
    left=left+1;
elseif(tmp_st{3*i}(count)==')')
    right=right+1;
end
end
haha{i}(count)='.';
    end

indent(1)=[];
end
haha{i}=haha{i}(tt==1);
tmpp=rnaconvert(haha{i});
[row,col]=find(tmpp);
stru{i}=row*1000+col;
end
len=cellfun(@length,stru);
dis=find_same(stru,2);
plot(dis)
saveas(gcf,[pwd,'/','ham_dis.jpg']); 
close
dis2=find_same(stru(1001:2000),1);
Z = linkage(squareform(dis2,'tovector'),'average');
c=dendrogram(Z);
saveas(gcf,[pwd,'/','tree.jpg']); 
close
save tree.mat
end