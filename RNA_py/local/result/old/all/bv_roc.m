function y=bv_roc(ind,bps)
name={'5S-rRNA';'5-8S-rRNA';'IRES-HCV';'Lysine';'RFN';'Retroviral-psi ';'SECIS ';'SRP-bact ';'SRP-euk-arch ';'S-box ';'T-box ';'THI ';'U1 ';'U2 ';'UnaL2 ';'sno-14q-I-II ';'tRNA'}; 
load bv.mat
figure
for i=1:length(ind)
subplot(length(ind),2,2*i-1)
%{
a=load(['en_roc_fam_',num2str(ind(i))]);
aa=load(['roc_1_fam_',num2str(ind(i))]);
aaa=load(['roc_2_fam_',num2str(ind(i))]);
hold on
plot([a(1:8,2);a(end,2);a(9:end-1,2)],[a(1:8,1);a(end,1);a(9:end-1,1)])
plot([aa(1:8,2);aa(end,2);aa(9:end-1,2)],[aa(1:8,1);aa(end,1);aa(9:end-1,1)],'r-')
plot([aaa(1:8,2);aaa(end,2);aaa(9:end-1,2)],[aaa(1:8,1);aaa(end,1);aaa(9:end-1,1)],'k-')
%}
a=load(['en_roc_fam_',num2str(ind(i)),'_ch']);
aa=load(['roc_1_fam_',num2str(ind(i)),'_ch']);
aaa=load(['roc_2_fam_',num2str(ind(i)),'_ch']);
hold on
plot(1-a(:,1),a(:,2))
plot(1-aa(:,1),aa(:,2),'r-')
plot(1-aaa(:,1),aaa(:,2),'k-')
xlabel('PPV')                                                             
ylabel('SEN')
title(name{ind(i)})
subplot(length(ind),2,2*i)

hold on
for ii=1:5
for iii=1:10
hold on
plot(mean(dis{iii}{5*(ind(i)-1)+ii})/bps(i),std(dis{iii}{5*(ind(i)-1)+ii})/bps(i),'b*','LineWidth',3)
end
title(name{ind(i)})
xlabel('bias per bp')
ylabel('std per bp')
end
end




%bias
%{
a=zeros(2,17);
for i=1:17
b=[];
for ii=1:5
for iii=1:10
b=[b,]
plot(mean(dis{iii}{5*(ind(i)-1)+ii})/bps(i),std(dis{iii}{5*(ind(i)-1)+ii})/bps(i),'b*','LineWidth',3)
end
end
end


%}
