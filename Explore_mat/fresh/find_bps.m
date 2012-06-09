function y=find_bps(seq)

bps=zeros(2,length(seq{1}));
% 1a  2g  3c  4u
for j=1:2
bps(j,find(seq{j}=='a'))=1;
bps(j,find(seq{j}=='g'))=2;
bps(j,find(seq{j}=='c'))=3;
bps(j,find(seq{j}=='u'))=4;
end



end