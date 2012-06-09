%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%0) inital data
%1A,2U,3G,4C
seq1=load('ini_1.txt');
seq2=load('ini_2.txt');

tmp=textread('seq.fa','%s');
seqq1=lower(tmp{1})
tmp=textread('sseq2.txt','%s');
seqq2=lower(tmp{1});
hah = nt2aa(seqq1,'geneticcode','Vertebrate Mitochondrial');


[GlobalScore, GlobalAlignment] = nwalign(seqq1,seqq2,'ALPHABET', 'NT');
matr1=matr(seq1);
matr2=matr(seq2);

matr1=con_leng(matr(seq1),5);
matr2=con_leng(matr(seq2),5);

imagesc(matr1)
hold on
figure
imagesc(20*matr2)

imagesc(ones(4))
hold on
plot(1:181,seq1,'b-')
plot(1:199,seq2,'r-')
legend('seq 1','seq 2')

image=zeros(2,199);
image(1,1:181)=10*seq1;
image(2,:)=10*seq2;
imagesc(image)
title('initial data')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) intial alignment
tmp=load('ini_aln.txt');
tmp1=[];tmp2=[];
for i=1:2:size(tmp,1)-1
tmp1=[tmp1,tmp(i,1:end-1)];
tmp2=[tmp2,tmp(i+1,1:end-1)];
end
tmp1=[tmp1,3];
tmp2=[tmp2,0];

image2=[tmp1;tmp2];
imagesc(image2)
title('initial align')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2)structure compare
load stru.mat
stru_1=load('str1');
stru_2=load('str2.txt');
stru_c=load('str_c.txt');
st1=rnaconvert(stru_1);
rnaplot(st1,'Format','graph')

colors=['b.';'g.';'r.';'m.';'y.';'k.';'c.';'bo';'go';'ro';'mo'];



index1_0=find(stru_1=='(');
index1_1=find(stru_1==')');
index2_0=find(stru_2=='(');
index2_1=find(stru_2==')');

seq1(index1_0)-seq2(index2_0)


%3%%%%%%%%%%%%%%%%%%%%%%%%%%
%true alin matrix
true=load('true_aln');


ttrue(1,:)='UUCUUAUCCAGAGUGGUGGAGGGAAUCGGCCCAGUGAAACCCGGCA..............GCGGAGCGCAAGUUCUAU.......GCUAAUUCCGAUCAGAA.GUAAUAUUCUGGCAGAUAAGUA';
ttrue(2,:)='UUCUUAUCCAGAGUGGUGGAGGGA.CUGGCCCUGUGAAGCCCGGCAACCUCUUUUUUUAA..................AGAAGGUGCCAAUUCCAG.CAGAACAUGAUGUUCUGAAAGAUAAGAA';
ttrue(1,:)='UUCUUAUCCAGAGUGGUGGAGGGAAUCGGCCCAGUGAAACCCGGC-A--GCGGAGCGCAAGUUCUAUGCUAAUUCCGAUCAGAA-GUAAUAUUCUGGCAGAUAAGUA';
ttrue(2,:)='UUCUUAUCCAGAGUGGUGGAGGGACU-GGCCCUGUGAAGCCCGGCAACCUCUUUUUUUAAAGAAGGUGCCAAUUCC-AGCAGAACAUGAUGUUCUGAAAGAUAAGAA';
ttrue(1,:)='UUCUUAUCCAGAG-UGGUGGAGGGAAUCGGCCCAGUGAAACC-CGGCAGCGGAGCGCAAGU---------------UCUAUGCUAAUUCCGAUCAGAAG---UAAUAUUCUGGCAGAUAAGUA';
ttrue(2,:)='UUCUUAUCCAGAG-UGGUGGAGGGACU-GGCCCUGUGAAGCC-CGGCAACCUCUUUUUUUAAAGAA------------GGUGCCAAUUCCAGCAGAACA---UGAUGUUCUGAAAGAUAAGAA';
true=ones(2,length(ttrue));
true(find(ttrue=='-'))=0;
aln_mat=[];
in_1=find(true(1,:));
in_2=find(true(2,:)==0);

for i=1:length(in_1)
    if(true(2,in_1(i))~=0)
    tmp=length(find(in_2<in_1(i)));
    aln_mat=[aln_mat;[i,in_1(i)-tmp]];
    end
end
plot(aln_mat(:,1),aln_mat(:,2),'b.')


sstt='.(((((((..(((..(((...(((......)))......))).)(((.(((.(((.......................................)))..))))))...))....(((((..........)...........))))...))))))).';
ind1=find(ttrue(1,:)=='-');
tt=zeros(1,length(ttrue));
tt(ind1)=1;
sstt=sstt(find(tt==0));