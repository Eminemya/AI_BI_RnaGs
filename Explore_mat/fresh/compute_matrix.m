num=2000;
matrix_1=zeros(num,num);
for i=1:num
    for j=1:num
        matrix_1(i,j)=constraint_new(struct{i},struct{j});
    end;
end;


