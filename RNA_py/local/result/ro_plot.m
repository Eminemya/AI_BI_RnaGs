%plot each family
colors=['r-';'go';'b*';'kx';'m.']
figure;
names={'en_roc','roc_1','roc_2'};
titles={'ensemble centroid','biggest centroid','2nd biggest centroid'};
for i=1:3
name=names{i};
eval(['cd ',name]);
subplot(2,2,i)
axis([0.3 1 0.2 1])
for ii=2:2:10
hold on
a=load([num2str(ii) '.roc']);
plot([a(1:8,2);a(end,2);a(9:end-1,2)],[a(1:8,1);a(end,1);a(9:end-1,1)],colors(ii/2,:))
end
legend('#seq=2','#seq=4','#seq=6','#seq=8','#seq=10')
title(titles{i}) 
xlabel('PPV')                                                             
ylabel('SEN')
cd ..
end
%saveas(gcf,[pwd,'/','roc.jpg']); 
%close


%plot each family
colors=['r-';'go';'b*';'kx';'m.']
figure;
names={'en_roc','roc_1','roc_2'};
titles={'ensemble centroid','biggest centroid','2nd biggest centroid'};
hold on
for i=1:3
name=names{i};
a=load(name);
plot([a(1:8,2);a(end,2);a(9:end-1,2)],[a(1:8,1);a(end,1);a(9:end-1,1)],colors(ii/2,:))
end
legend('#seq=2','#seq=4','#seq=6','#seq=8','#seq=10')
title(titles{i}) 
xlabel('PPV')                                                             
ylabel('SEN')
cd ..
end
%saveas(gcf,[pwd,'/','roc.jpg']); 
%close

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

