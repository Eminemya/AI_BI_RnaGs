function [ y ] = matr( seq)
%MATR Summary of this function goes here
%   Detailed explanation goes here

y=zeros(length(seq));
%seqq=fliplr(seq);
for i=1:length(seq)
    for j=i:length(seq)
   if(seq(i)+seq(j)==5)
   y(i,j)=10;
   end
    end
end
end

