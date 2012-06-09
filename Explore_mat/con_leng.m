function y=con_leng(matr,len)

%the least length of the stem
a=length(matr);
ind=find(matr==10);
tmp_10=[];

%top
for i=2*len-1:a
    tmp=ones(1,ceil(i/2))*((i-1)*a+1)-(0:(a-1):(ceil(i/2)-1)*(a-1));
    tmp0=matr(tmp);
    
    tmp1=find(tmp0==10);
    tmp2=(tmp1(1:end-len+1)+len-1)-tmp1(len:end);
    tmp_10=[tmp_10,tmp(tmp1(find(tmp2==0)))];
end
%right
for i=2:a-2*(len-1)
    tmp=ones(1,ceil(i/2))*((i-1)*a+1)-(0:(a-1):(ceil(i/2)-1)*(a-1));
    tmp0=matr(tmp);
    tmp1=find(tmp0==10);
    tmp2=(tmp1(1:end-len+1)+len-1)-tmp1(len:end);
    tmp_10=[tmp_10,tmp(tmp1(find(tmp2==0)))];
end

y=zeros(a);
tt=repmat(tmp_10,len,1)-repmat([0:(a-1):(a-1)*(len-1)]',1,length(tmp_10));
y(tt)=10;
end