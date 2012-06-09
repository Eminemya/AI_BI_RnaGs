%%%%initial to aln
for i=1:10
tmp=textread(['/home/donglai/Desktop/RNA/GS/test_2/' num2str(i) '/seq.fa'],'%s');
tmp=textread([pwd '/ribo.txt'],'%s');
seqq1=lower(tmp{1})
seqq2=lower(tmp{2});
seqq3=lower(tmp{3});
seqq4=lower(tmp{4});
seqq5=lower(tmp{5});

tmp=textread([pwd '/ribo.txt'],'%s');
seqq1=tmp{1};
tmp1=textread([pwd '/ribo.txt'],'%s');
seqq2=lower(tmp1{1});

seqq{1}='UUCUUAUCCAGAGUGGUGGAGGGAAUCGGCCCAGUGAAACCCGGCAGCGGAGCGCAAGUUCUAUGCUAAUUCCGAUCAGAAGUAAUAUUCUGGCAGAUAAGUA';
seqq{2}='UUCUUAUCCAGAGUGGUGGAGGGACUGGCCCUGUGAAGCCCGGCAACCUCUUUUUUUAAAGAAGGUGCCAAUUCCAGCAGAACAUGAUGUUCUGAAAGAUAAGAA';
seqq{3}='CUCUUAUCACGAGAGGUGGAGGGAUGUGCCCUUUGAAGCCCGGCAACCGUCUGUAACAGAAAUGGUGCCAAUUCACAUAAAGUUCAUAGAAACUUUAGAAGAUGAGAG';
seqq{4}='UUCUUAUCAAGAGCAGGUGGAGGGACGAGCCCGACGAAACCCGGCAACCGAUCUACAUAAUUGUAGACACGGUGCUAAUUCUCGCAGCAUUACGCUGACAGAUAAGGA';
seqq{5}='UCCUUAUCGAGAGAGGCGGAGGGACUGGCCCGAAGAAGCCCGGCAACCUGCAUAAUUUAACAAAAUUAUGCAAUGGUGCUAAAUCCUGCAGAGAAAUUCUGGGAGAUAAGGA';
seqq{6}='GGUUCAUCGAGAGUGGCGGAGGGACUGGCCCCAUGAUGCCACGGCAACCUCUCCCGCGGGGAGAACGGUGCCAAAUCCAGCGGACACUCGGUCCGAGAGAUGAAGC';
seqq{7}='CUCUUAUCCAGAGAGGUGGAGGGAACUGGCCCGAUGAAACCCGGCAACCCAGGACGCUGCGGGGCGUCCGAAGGUGCCAACUCCACCGGCGGCCUCACGCCGCCGGAAGAUAAGAG';
seqq{8}='AACUCAUCCAGAGGGGUGGAGGGAUCGGCCCUAUGAAACCCCGGCAACCGCAGGCAGCAAUGCUUGGACUGGUGCUAAGUCCGACAGAAUCAUUCUGGAAGAUGAGGG';
seqq{9}='UUCUUAUUAAGAGAGGUGGAGGGACUGGCCCUUCGAAGCCUCAGCAACCUGAUUUAUGUGAUAUAAAGGUGCUAAAUCCUGUAGGAUAUAAAAGUCCUAAUAGAUAAGAA';
seqq{10}='UACUUAUCAAGAGAGGUGGAGGGACUGGCCCGCUGAAACCUCAGCAACAGAACGCAUCUGUCUGUGCUAAAUCCUGCAAGCAAUAGCUUGAAAGAUAAGUU';
qqq=multialign(seqq,'terminalGapAdjust',true)
dlmwrite(['/home/donglai/Desktop/mat.aln'], qqq([1,2],:),'')

hah = nt2aa(seqq1,'geneticcode','Vertebrate Mitochondrial');
[GlobalScore, GlobalAlignment] = nwalign(seqq1,seqq2,'ALPHABET', 'NT');
dlmwrite(['/home/donglai/Desktop/mat.aln'], GlobalAlignment([1,3],:),'')
end

%%%%% aln to sta:
for ww=1:10
base=['/home/donglai/Desktop/RNA/GS/test_2/' num2str(ww)];
true_aln=textread([base '/true_align'],'%s');
true_bp=aln_bp(true_aln);
F=length(find(true_aln{1}~='-'))+length(find(true_aln{2}~='-'))-2*length(true_bp);
tmp=textread([base '/00aln.file'],'%s');
aln=cell(1,1000);
MCC=zeros(1,1000);
SPE=zeros(1,1000);
SEN=zeros(1,1000);
CC=zeros(1,1000);
PPV=zeros(1,1000);
for i=1:1000
    haha{1}=tmp{4*(i-1)+3};
    haha{2}=tmp{4*(i-1)+4};
aln{i}=aln_bp(haha);
[MCC(i),SPE(i),SEN(i),CC(i),PPV(i)]=sta(aln{i},[],true_bp,F,1);
end
%{
hold on
plot(aln{i}(:,1),aln{i}(:,1),'b.')
plot(true_bp(:,1),true_bp(:,2),'r.')
%}
subplot(3,1,1)
hold on
plot(1:1000,CC,'b-')
plot(1:1000,CC(1)*ones(1,1000),'r-')
title('CC vs step')
legend(['test',num2str(ww),' gibbs','initial nwalign'])
subplot(3,1,2)
hold on
plot(1:1000,PPV,'b-')
plot(1:1000,PPV(1)*ones(1,1000),'r-')
title(['test',num2str(ww),'PPV vs step'])
legend('gibbs','initial nwalign')
subplot(3,1,3)
hold on
plot(1:1000,SEN,'b-')
plot(1:1000,SEN(1)*ones(1,1000),'r-')
title(['test',num2str(ww) 'SEN vs step'])
legend('gibbs','initial nwalign')
end


%%%%% stru to sta:
for ww=1:10
base=['/home/donglai/Desktop/RNA/GS/test_2/' num2str(ww)];
true_stru=textread([base '/true_stu.pss'],'%s');
true_stru{1}(find(true_stru{1}=='<'))='(';
true_stru{1}(find(true_stru{1}=='>'))=')';
table=sparse(rnaconvert(true_stru{1}));
tmp_aln=textread([base '/00aln.file'],'%s');
%F=length(find(true_aln{1}~='-'))+length(find(true_aln{2}~='-'))-2*length(true_bp);
tmp=textread([base '/00stru.file'],'%s');
stru=cell(1,1000);
MCC=zeros(1,1000);
SPE=zeros(1,1000);
SEN=zeros(1,1000);
CC=zeros(1,1000);
PPV=zeros(1,1000);
for i=1:1000
haha=tmp{3*i};
stru{i}=sparse(rnaconvert(haha));
[MCC(i),SPE(i),SEN(i),CC(i),PPV(i)]=sta(aln{i},stru{i},true_bp,F,0);
end

%{
hold on
plot(aln{i}(:,1),aln{i}(:,1),'b.')
plot(true_bp(:,1),true_bp(:,2),'r.')
%}
subplot(3,1,1)
hold on
plot(1:1000,CC,'b-')
plot(1:1000,CC(1)*ones(1,1000),'r-')
title('CC vs step')
legend('test',num2str(w),' gibbs','initial nwalign')
subplot(3,1,2)
hold on
plot(1:1000,PPV,'b-')
plot(1:1000,PPV(1)*ones(1,1000),'r-')
title('PPV vs step')
legend('test',num2str(w),'gibbs','initial nwalign')
subplot(3,1,3)
hold on
plot(1:1000,SEN,'b-')
plot(1:1000,SEN(1)*ones(1,1000),'r-')
title('CC vs step')
legend('test',num2str(w),'gibbs','initial nwalign')
end





















figure
hold on
plot(1:999,MCC(1:end-1),'b-')
plot(1:999,MCC(1)*ones(1,999),'r-')
title('MCC vs step')
legend('gibbs','initial nwalign')