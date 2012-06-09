


ww=0;
num_seq=10
base=['/home/donglai/Desktop/RNA/test/' num2str(ww)];
tmp_al=textread([base '/00aln'],'%s');
tmp_st=textread([base '/00str'],'%s');
true_st=textread([base '/tru_str'],'%s');
haha=cell(1,2000);

w=zeros(1,2000);
q=zeros(1,2000);
qq=zeros(1,2000);
for i=1:2000
haha2=tmp_al{(num_seq+2)*(i-1)+3};
w(i)=length(haha2)-sum(haha2=='.')-sum(haha2=='-');
q(i)=length(haha2);
qq(i)=length(tmp_st{3*i});
end




for i=1:1999
haha2=tmp_al{(num_seq+2)*(i-1)+3};
ind=find(haha2=='.');
haha{i}=tmp_st{3*i+3};
indent=[ind,find(haha2=='-')];
tt=ones(1,length(haha2));
tt(indent)=0;
while(~isempty(indent))
    if(haha{i}(indent(1))~='.')
if(tmp_st{3*i+3}(indent(1))=='(')
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
if(tmp_st{3*i+3}(count)=='(')
    left=left+1;
elseif(tmp_st{3*i+3}(count)==')')
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

tt='<..<...<<.<<<<<...<<..<<<<<<.......>>..>>>>..>>....>>>>>..>><<<.<<..<...<<....>>....>.>>.>>>>>...';
tt(tt=='<')='(';
tt(tt=='>')=')';
tmpp=rnaconvert(tt);
[row,col]=find(tmpp);
true=row*1000+col;


len=cellfun(@length,stru);
dis=find_same(stru,true,2);
dis2=find_same(stru(1000:1999),true,1);



Z = linkage(squareform(dis2,'tovector'),'average');
c=dendrogram(Z);

