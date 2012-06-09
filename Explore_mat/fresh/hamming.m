function y=hamming(Series,lags)
y=sum(sum(Series(:,1:length(Series)-lags)'-ones(length(Series)-lags,1)*mean(Series'),2).*sum(Series(:,lags+1:length(Series))'-ones(length(Series)-lags,1)*mean(Series'),2))/sum(sum(Series'-ones(length(Series),1)*mean(Series'),2).^2);
end