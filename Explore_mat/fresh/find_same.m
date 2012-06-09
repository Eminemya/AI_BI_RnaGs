
function y=find_same(stru,what,mode)
if(mode==1)
%dist matrix
y=zeros(length(stru));
for i=1:length(stru)
    for j=i+1:length(stru)        
        y(i,j)=dist_ham(stru{i},stru{j});
    end
end
y=y+y';
elseif(mode==2)
%evaluation()
y=zeros(1,length(stru));
for i=1:length(stru)
y(i)=dist_ham(what,stru{i});
end
end
end

function y=dist_ham(t1,t2)

he=unique([t1;t2]);
y=2*length(he)-length(t1)-length(t2);
end