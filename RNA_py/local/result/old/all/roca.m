function s=roca(data)

%head
a=data(15,1)
a=data(16,1)
test=data(16,1)*abs(data(16,1)-data(15,1))*abs(data(16,2)-data(15,2));
if(data(16,2)+test>1)
x=1-data(16,2);
s=s+x*(x+2*test)*a/(2*test);
else
s=s+test*a/2;
end
%tail
if(data(15,:))
a=data(15,1)
a=data(16,1)
test=data(16,1)*abs(data(16,1)-data(15,1))*abs(data(16,2)-data(15,2));
if(data(16,2)+test>1)
x=1-data(16,2);
s=s+x*(x+2*test)*a/(2*test);
else
s=s+test*a/2;
end


tt=[data(1:8,:);data(17,:);data(9:16,:)];
s=0;
for i=1:18
s=s+abs(tt(i,2)-tt(i+1,2))*(tt(i,1)+tt(i+1,1))/2;
end

end
