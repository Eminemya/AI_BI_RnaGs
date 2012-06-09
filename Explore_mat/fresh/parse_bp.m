function y=parse_bp(st,N)

a=zeros(1,length(st)-2);
for i=1:length(st)-2
a(i)=str2num(st{i+2});
end
y='';
for i=1:N
if(length(find(a==i))==1)
    if(mod(find(a==i),2)==1)
    y=[y '('];
    else
    y=[y ')'];    
    end
else
    y=[y '.'];
end
%y
end

end