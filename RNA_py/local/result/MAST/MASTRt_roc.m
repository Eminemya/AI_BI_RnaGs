pp=[0.57,0.73;0.38,0.81;0.41,0.77;0.64,0.73;0.62,0.78;0.55,0.55;0.65,0.70;0.68,0.77];
colors=['go';'k<';'md';'cs';'y>';'k^';'m*';'gv']
colorss=['r-o';'b-o'];

cd Sep
%cd total
figure;
names={'en_roc_all','roc_1_all'};
titles={'ensemble centroid','biggest centroid','2nd biggest centroid'};
hold on
for i=1:2
name=names{i};
a=load(name);
plot([a(1:8,1);a(end,1);a(9:end-1,1)],[a(1:8,2);a(end,2);a(9:end-1,2)],colorss(i,:))
end

for i=1:size(pp,1)
plot(pp(i,2),pp(i,1),colors(i,:),'MarkerSize',10)
end

legend('RNAG ensemble','RNAG 1st cluster','CLUSTAL+Alifold','FoldalignM','LocARNA','MASTR','Murlet','RNAforester','RNA Sampler','RAF')
title('Comparison on MASTR dataset') 
xlabel('PPV')
ylabel('SEN')


figure
hold on
a=load('en_roc')
plot([a(1:8,2);a(end,2);a(9:end-1,2)],[a(1:8,1);a(end,1);a(9:end-1,1)],'ro')
plot(0.84,0.78,'bo')
a=load('en_roc_g')
plot([a(1:8,2);a(end,2);a(9:end-1,2)],[a(1:8,1);a(end,1);a(9:end-1,1)],'kx')
a=load('haha')
plot([a(1:8,2);a(end,2);a(9:end-1,2)],[a(1:8,1);a(end,1);a(9:end-1,1)],'m*')
plot(0.77,0.52,'gd')
legend('Reference-RNAalifold-Sample','Reference-RNAalifold-MFE','Probcons-Gibbs-Sample','Probcons-RNAalifold-Sample','Probcons-RNAalifold-MFE')

