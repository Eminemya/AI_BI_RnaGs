colors=['g^';'k<';'md';'cs';'y>';'k^';'m*';'gv']
colorss=['r-o';'b-o'];


tt_en=zeros(17,2);
for i=1:4
a=load(['en_roc_' num2str(i)]);
tt_en=tt_en+a;
end
tt_en=tt_en/4;


tt_roc=zeros(17,2);
for i=1:4
a=load(['roc_1_' num2str(i)]);
tt_roc=tt_roc+a;
end
tt_roc=tt_roc/4;

pp=[0.7,0.7;0.55,0.6;0.55,0.64;0.66,0.66];
pp=pp+[0.75,0.76;0.79,0.65;0.77,0.65;0.83,0.65];
pp=pp+[0.86,0.90;0.86,0.9;0.93,0.91;0.81,0.85];
pp=pp+[0.69,0.75;0.56,0.61;0.75,0.7;0.83,0.79];
pp=pp/4;

tt=cell(1,2);
tt{1}=tt_en;
tt{2}=tt_roc;

figure;
hold on

for i=1:2
a=tt{i};
plot([a(1:8,1);a(end,1);a(9:end-1,1)],[a(1:8,2);a(end,2);a(9:end-1,2)],colorss(i,:))
end

for i=1:size(pp,1)
plot(pp(i,2),pp(i,1),colors(i,:),'MarkerSize',10)
end

title(['Comparison on BRAliBASE II dataset']) 
xlabel('PPV')
ylabel('SEN')
axis tight

legend('RNAG ensemble','RNAG 1st cluster','Murlet','LocARNA','RNA Sampler','RAF')

