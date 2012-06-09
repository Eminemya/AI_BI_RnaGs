colors={'-ok','-^k','-or','-^g','--or','--^g','-sb','md','ob'}
figure;
hold on
for i=1:9
plot(1,1,colors{i})
end
legend('Gibbs Sampling (ensemble)','Gibbs Sampling (1st biggest cluster)','CentroidAlifold(new; al-mc)','CentroidAlifold (new; al-ct)','CentroidAlifold (old; mc)','CentroidAlifold (old; ct)','RNAalipfold−Centroid','PETfold','RNAalifold')

figure
a=load('en_roc');
b=load('roc_1');
hold on
plot(a(:,2),a(:,1),'-ok');
plot(b(:,2),b(:,1),'-^k');

