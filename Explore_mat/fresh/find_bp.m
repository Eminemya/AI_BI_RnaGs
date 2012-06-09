function y=find_bp(seq)
a=seq{1};
b=seq{2};
a1=find(a~='-');
find(b(a1)~='-');
y=[a1(find(b(a1)~='-'));a1(find(b(a1)~='-'))];

end