colors=['go';'k<';'md';'cs';'y>';'k^';'m*';'gv']
colorss=['r-o';'b-o'];

pp=cell(1,4);
pp{1}=[0.7,0.7;0.55,0.6;0.55,0.64;0.66,0.66];
pp{2}=[0.75,0.76;0.79,0.65;0.77,0.65;0.83,0.65];
pp{3}=[0.86,0.90;0.86,0.9;0.93,0.91;0.81,0.85];
pp{4}=[0.69,0.75;0.56,0.61;0.75,0.7;0.83,0.79];

figure;
for zz=1:4
subplot(2,2,zz)
names={['en_roc_' num2str(zz)],['roc_1_' num2str(zz)]};
titles={'5S rRNA','group II intron','tRNA','U5'};
hold on
for i=1:2
name=names{i};
a=load(name);
plot([a(1:8,1);a(end,1);a(9:end-1,1)],[a(1:8,2);a(end,2);a(9:end-1,2)],colorss(i,:))
end

for i=1:size(pp{zz},1)
plot(pp{zz}(i,2),pp{zz}(i,1),colors(i,:),'MarkerSize',10)
end
title(['Comparison on ' titles{zz} ' dataset']) 
xlabel('PPV')                                                             
ylabel('SEN')
axis tight
end
legend('RNAG ensemble','RNAG 1st cluster','Murlet','LocARNA','RNA Sampler','RAF')

