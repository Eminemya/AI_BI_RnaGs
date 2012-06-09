tmp=textread([pwd '/aa.txt'],'%s');

tmpp=multialign(tmp(1:3));
dlmwrite(['/home/donglai/Desktop/ribo/G/3/mat.aln'], tmpp,'')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sfold
tru_stu=textread([pwd '/stru.txt'],'%s');
for i=1:5
rnaplot(tru_stu{i},'Format','circle')
end
w=5
for ww=1:2
c1=textread(['/home/donglai/Desktop/ribo/output' num2str(w) '/clusters/c0' num2str(ww) '.ccentroid.bp'],'%s');
y=parse_bp(c1,length(tru_stu{w}));
rnaplot(y,'Format','circle')
end


%autocorrelation


tmp=textread([pwd '/riboo.txt'],'%s');
seqq1=tmp{1};
tmp1=textread([pwd '/ribo.txt'],'%s');
seqq2=lower(tmp1{1});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gibbs 2
ww=2;
base=['/home/donglai/Desktop/RNA/ribo/G_new/' num2str(ww)];
tmp_al=textread([base '/00aln.file'],'%s');
tmp_st=textread([base '/00stru.file'],'%s');

%tmp_true=textread([pwd '/true_stu.txt'],'%s');

stru1=cell(1,1000);
stru2_seq1=cell(1,2000);
for i=1:2000
xx(i)=length(tmp_st{3*i});
yy(i)=length(tmp_al{4*i});
end
find(xx-yy)
find(yy(1:end-1)-xx(2:end))

haha=cell(1);
score=[0,1,2]
for i=1:2000
haha=tmp_st{(3)*i};
haha2=tmp_al{(ww+2)*(i-1)+2+2};
ind=find(haha2~='-');
haha=haha(ind);
haha2=haha2(ind);
ind=find(haha2~='.');
haha=haha(ind);
haha2=haha2(ind);
tmp_str{i}=zeros(1,length(haha));
tmp_str{i}(find(haha=='('))=score(2);
tmp_str{i}(find(haha==')'))=score(3);
end


Series=zeros(97,2000);
for i=1:2000
Series(:,i)=tmp_str{i};
end
[c_ww,lags] = xcorr(Series(:,100),100,'coeff');
stem(lags,c_ww)

count=0;
%hard code lag=100
for lags=0:5:100
count=count+1;
    y(count)=hamming(Series,lags);
end


dis=find_dis(tmp_str(1:2000),2);
plot(dis)
test=1990
rnaplot(tmp_st{3*test},'Sequence',tmp_al{4*test},'Format','diagram')
rnaplot(tmp_st{3*test},'Sequence',tmp_al{4*test-1},'Format','diagram')
y=find_dis(tmp_str(1000:2000),1);
Z = linkage(squareform(y,'tovector'),'average');
c=dendrogram(Z);
T= cluster(Z,'maxclust',2); 
T1=find(T==1);
T2=find(T==2);
dis=find_dis(tmp_str(1000:2000),0);
plot(1:1001,[dis(T1),dis(T2)])
save T_stu.mat T T1 T2
%centroid
tt=zeros(3,length(tmp_str{1}));
for i=1:length(T1)
ttp=tmp_str{999+T1(i)}+1;
tt(ttp+(0:3:3*(length(tmp_str{i})-1)))=tt(ttp+(0:3:3*(length(tmp_str{1})-1)))+1;
end
for i=1:length(T2)
tt=tt+tmp_str{999+T2(i)};
end

tt=tt/length(T1);tt=zeros(3,length(tmp_str{1}));
for i=1:length(T1)
ttp=tmp_str{999+T1(i)}+1;
tt(ttp+(0:3:3*(length(tmp_str{i})-1)))=tt(ttp+(0:3:3*(length(tmp_str{1})-1)))+1;
end

tt(find(tt<0.5))=0;
ind=find(tt>=0.5);
tt(ind(find(tt(ind)<1.5)))=1;
tt(find(tt>1))=2;

tt_1=tt;
tt_2=tt;
rr1=num2char(tt_1,length(tmp_str{1}))
rr2=num2char(tt_2,length(tmp_str{1}))
TT= cluster(Z,'maxclust',4); 
TT4=find(TT==4);
TT3=find(TT==3)
TT2=find(TT==2)
TT1=find(TT==1)

rnaplot(tmp_st{(999+T1(TT3(1)))*3},'Format','circle')
T1(TT2)
T1(TT3)

[Y,eigvals] = cmdscale(y);

plot3(Y(T1,1),Y(T1,2),'b.')
plot(Y(T2,1),Y(T2,2),'r.')
plot(Y(T3,1),Y(T3,2),'g.')
plot(Y(T4,1),Y(T4,2),'m.')


%aln dependent
for i=1:2000
haha=tmp_st{(ww+1)*i};
haha2=tmp_al{(ww+2)*i};
tmpp=rnaconvert(haha);
[row,col]=find(tmpp);
stru{i}=row*1000+col;
%{
haha2=haha2(find(haha2~='-'));
haha=haha(find(haha2~='-'));
if(length(haha2)==length(haha))
hehe=haha(find(haha2=='-'));
tmpp=rnaconvert(hehe);
[row,col]=find(tmpp);
stru_seq1{i}=row*1000+col;
end
stru_seq1(find(cellfun(@isempty,stru_seq1)==1))=[];
%}
end

tmpp=rnaconvert(tmp_true{1});
[row,col]=find(tmpp);



%{

%}
%a=[1000*row+col,stru];
a=[stru{1},stru];
dis=find_same(a,2);
plot(1:length(dis),dis)
rnaplot(tmp_st{3},'Format','dotdiagram')
rnaplot(tmp_st{3*1000},'Sequence',tmp_al{4*1000},'Format','diagram')
rnaplot(tmp_st{3*1000},'Format','circle')
ind=find(dis>50)
rnaplot(tmp_st{3*ind(end-10)},'Sequence',tmp_al{4*ind(end-10)},'Format','diagram')
rnaplot(tmp_st{3*ind(end-10)},'Format','circle')
rnaplot(tmp_st{3},'Format','circle')
gib=dis(1000:end)

ttt=cell(1,2)
ttt{1}=1000*row+col;
ttt{2}=stru{1977};
find_same(ttt,2)

rnaplot(tmp_st{3*3000},'Format','circle')
rnaplot(tmp_st{3*17},'Format','circle')
rnaplot(tmp_true{1},'Format','circle')
y=find_same(stru,1);



y=find_same(aln(1000:2000),1);
%y=find_same(stru(1000:2000),1);
Z = linkage(squareform(y,'tovector'),'average');
c=dendrogram(Z);
T= cluster(Z,'maxclust',2); 
T1=find(T==1);
T2=find(T==2);
T3=find(T==3);
T4=find(T==4);

%y1=find_same(stru(999+T1),1);
Z1 = linkage(squareform(y(T1,T1),'tovector'),'average');
c1=dendrogram(Z1);
TT= cluster(Z1,'maxclust',3); 
TT3=find(TT==3)
TT2=find(TT==2)
TT1=find(TT==1)

rnaplot(tmp_st{(999+T1(TT3(1)))*3},'Format','circle')
T1(TT2)
T1(TT3)

[Y,eigvals] = cmdscale(y);

plot3(Y(T1,1),Y(T1,2),'b.')
plot(Y(T2,1),Y(T2,2),'r.')
plot(Y(T3,1),Y(T3,2),'g.')
plot(Y(T4,1),Y(T4,2),'m.')




%%%sfold bp2(..)

for ww=1:5
tmp=textread(['/home/donglai/Desktop/RNA/others/sfold-2.1/bin/output1/clusters/c0' num2str(ww) '.ccentroid.bp'],'%s');
tmp=tmp(3:end)
    str='';
for i=1:length(seqq1)
str=[str '.'];
end
for i=1:length(tmp)/2
str(str2num(tmp{2*(i-1)+1}))='(';
str(str2num(tmp{2*i}))=')';
end
%rnaplot(str,'Sequence',seqq2,'Format','diagram')
rnaplot(str,'Format','circle')
end

%1 find concensus(same length)
for i=1:2000
for j=1:ww
haha{j}=tmp_al{(ww+2)*(i-1)+2+j};
end
cons{i}=[];
for j=1:length(haha{1})
tmp=0;
for qq=1:ww
if(haha{qq}(j)=='.')
    tmp=tmp+1;
end
end
if(tmp==0)
cons{i}=[cons{i},j];
end
end
constr{i}=tmp_st{3*i}(cons{i});
end
len=cellfun(@length,constr);

