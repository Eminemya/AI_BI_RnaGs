load bv.mat
bb=zeros(1,17);
vv=zeros(1,17);
for i=1:17
tt=[];
for ii=1:5
for iii=1:10
tt=[tt,dis{iii}{(i-1)*5+ii}];
end
end
bb(i)=mean(tt);
vv(i)=std(tt);
end

order=[11,17,1,2,6,13,14,16,4,5,10,12,3,7,15,8,9];
bb=bb(order)
vv=vv(order)
