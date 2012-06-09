%%%June 2

ww=10;
base=['/home/donglai/Desktop/RNA/ribo/G_new/' num2str(ww)];
tmp_al=textread([base '/00aln.file'],'%s');
tmp_st=textread([base '/00stru.file'],'%s');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a) str
%0) aln-indepen:rid of '.'



%2 str for one seq
%aln dependent
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
dis2=find_same(stru(1001:2000),1);
Z = linkage(squareform(dis2,'tovector'),'average');
c=dendrogram(Z);
num_clus=4
TT= cluster(Z,'maxclust',num_clus); 
for i=1:num_clus
T(i)=length(find(TT==i));
end

Z2 = linkage(squareform(dis2(find(TT==2),find(TT==2)),'tovector'),'average');
c2=dendrogram(Z2);
TT2= cluster(Z2,'maxclust',num_clus); 
for i=1:num_clus
T2(i)=length(find(TT2==i));
end



www=1
rnaplot(haha{www},'Sequence',tmp_al{(ww+2)*(www-1)+3}((tmp_al{(ww+2)*(www-1)+3}~='.').*(tmp_al{(ww+2)*(www-1)+3}~='-')==1),'Format','diagram')


www=1990
rnaplot(tmp_st{3*www},'Sequence',tmp_al{(www+2)*(www-1)+2+7},'Format','diagram')
Series=zeros(length(haha{1}),2000);
for i=1:2000   
    tmp=zeros(length(haha{1}),1);
    tmp(haha{i}==')')=1;
    tmp(haha{i}=='(')=2;
Series(:,i)=tmp;
end
[c_ww,lags] = xcorr(Series(:,100),100,'coeff');
stem(lags(101:end),c_ww(101:end))

count=0;
%hard code lag=100
y=zeros(1,21);
for lags=0:5:100
count=count+1;
    y(count)=hamming(Series,lags);
end


dis=find_same(stru,2);




%plot rfam???from rfam...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%b) cluster aln
%%%%cluster aln
for i=1:2000
haha2=tmp_al{(ww+2)*i};
haha3=tmp_al{(ww+2)*i-1};
aln_mat=[];
count=[1,1];
for ii=1:length(haha2)
if(haha2(ii)~='-'&& haha3(ii)~='-'&&haha2(ii)~='.'&& haha3(ii)~='.')
aln_mat=[aln_mat;count];
count=count+[1,1];
elseif(haha2(ii)~='-'&&haha2(ii)~='.')
count=count+[1,0];
else
    count=count+[0,1];
end
end
aln{i}=aln_mat(:,1)*1000+aln_mat(:,2);
end
% dis=find_same(aln,2);
y=find_same(aln(1001:2000),1);




Z = linkage(squareform(y,'tovector'),'average');
c=dendrogram(Z);
TT= cluster(Z,'maxclust',4); 
T(1)=length(find(TT==1));
T(2)=length(find(TT==2));
T(3)=length(find(TT==3));
T(4)=length(find(TT==4));

y=find_same(aln(1000+find(TT==2)),1);
Z = linkage(squareform(y,'tovector'),'average');
c=dendrogram(Z);
TTT= cluster(Z,'maxclust',2); 
T2(1)=length(find(TTT==1));
T2(2)=length(find(TTT==2));





%%%%%how does it look like compared to Rfam......useless...
aln='UUC.UUAU.C.CAGAG.UGG.U..GG..AG.GGAA.UCGG..........................................CC..C..AGUGAA...ACC..CGGC.A..........................GCGGAGCGCAAGUUCUAU........................................................................GC.UA.A.UUC..CGAU.CAGAA.GUAAU....AU..................................................UCUG.GC.A.GAUAAGUA';
ind1=find(cluster==1);
qq=ind1(randsample(length(ind1),1));
tmp_a=tmp_al{(ww+2)*(qq-1)+3}
a1=find(tmp_a=='-');
a2=find(aln~='.');
stu='';
for i=1:length(aln)
stu=[stu '.'];
end
ss=tmp_st{3*qq};
s1=find(ss=='(');
for i=1:length(s1)
if(tmp_a(s1(i))~='-')
    stu(a2(s1(i)-length(find(a1<s1(i)))))='(';
    pre=a2(s1(i)-length(find(a1<s1(i))));
else
    stu(pre+1)='(';
    pre=pre+1;
end
end
s2=find(ss==')');
for i=1:length(s2)
if(tmp_a(s2(i))~='-')
    stu(a2(s2(i)-length(find(a1<s2(i)))))=')';
    pre=a2(s2(i)-length(find(a1<s2(i))));
else
    stu(pre+1)=')';
    pre=pre+1;
end
end
rnaplot(stu,'Sequence',aln,'Format','diagram')


%centroid
ind1=find(cluster==1);
qq=ind1(randsample(length(ind1),1));
qq1=qq;

ind2=find(cluster==2);
qq=ind2(randsample(length(ind2),1));

ind3=find(cluster==4);
qq=ind3(randsample(length(ind3),1));


tmp_a=tmp_al{(ww+2)*(qq-1)+3}
ss=tmp_st{3*qq};
rnaplot(ss,'Format','circle')

rnaplot(ss,'Sequence',tmp_a,'Format','diagram')
