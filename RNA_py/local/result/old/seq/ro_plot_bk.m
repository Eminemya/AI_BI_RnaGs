% plot whole
a=load('en_roc')
aa=load('roc_1')
aaa=load('roc_2')
hold on
plot([a(1:8,2);a(end,2);a(9:end-1,2)],[a(1:8,1);a(end,1);a(9:end-1,1)])
plot([aa(1:8,2);aa(end,2);aa(9:end-1,2)],[aa(1:8,1);aa(end,1);aa(9:end-1,1)],'r-')
plot([aaa(1:8,2);aaa(end,2);aaa(9:end-1,2)],[aaa(1:8,1);aaa(end,1);aaa(9:end-1,1)],'k-')
legend('ensemble centroid','1st cluster centroid','2nd cluster centroid','Best')
title('roc curve with probcon initialization') 
xlabel('PPV')                                                             
ylabel('SEN')
saveas(gcf,[pwd,'/','roc.jpg']); 
close

%plot each family
name=[pwd '/all'];
eval(['cd ',name]);
figure
for i=1:17
subplot(6,3,i)
a=load(['en_roc_fam_',num2str(i)]);
aa=load(['roc_1_fam_',num2str(i)]);
aaa=load(['roc_2_fam_',num2str(i)]);
hold on
plot([a(1:8,2);a(end,2);a(9:end-1,2)],[a(1:8,1);a(end,1);a(9:end-1,1)])
plot([aa(1:8,2);aa(end,2);aa(9:end-1,2)],[aa(1:8,1);aa(end,1);aa(9:end-1,1)],'r-')
plot([aaa(1:8,2);aaa(end,2);aaa(9:end-1,2)],[aaa(1:8,1);aaa(end,1);aaa(9:end-1,1)],'k-')
%legend('ensemble centroid','1st cluster centroid','2nd cluster centroid','Best')
%title('roc curve with probcon initialization') 
xlabel('PPV')                                                             
ylabel('SEN')
end
saveas(gcf,[pwd,'/','roc.jpg']); 
close

