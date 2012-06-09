function y=find_bifur(seq)

ind1=find(seq=='.');
ind2=find(seq~='.');
tmp=seq(ind2);
y=[];
for i=1:length(tmp)-1
if(tmp(i)==')')
    if(tmp(i+1)=='(')
        y=[y;[i+length(find(ind1<ind2(i))),i+1+length(find(ind1<ind2(i+1)))]];
    end
end
end

%add first and last bifur
indl=find(seq=='(');
indr=find(seq==')');
b=length(find(seq(1:y(1,1))==')'));
a=length(find(seq(1:y(1,1))=='('))-b;
y=[[indl(a),indl(a+1)];y];

b=length(find(seq(y(end,1)+1:end)=='('));
a=length(find(seq(y(end,1)+1:end)==')'))-b;
y=[y;[indr(length(indr)-a),indr(length(indr)-a+1)]];

end