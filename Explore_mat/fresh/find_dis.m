function y=find_dis(seq,cluster)

if(cluster==1)
y=zeros(length(seq));
for i=1:length(seq)
for j=i+1:length(seq)
y(i,j)=find_pd(seq{i},seq{j});
end
end
y=y+y';
else
%compare with the first one
y=zeros(1,length(seq));
for j=1:length(seq)
y(j)=find_pd(seq{cluster},seq{j});
end

end


end


function y=find_pd(seq1,seq2)
ww=abs(seq1-seq2);
ww(find(ww==2))=1;
y=sum(ww);
end