function num_cross=constraint_new(struct1,struct2)
num_cross=0;
for i=1:size(struct1,1)
    for j=1:size(struct2,1)
        if cross_pair(struct1(i,:),struct2(j,:))==0
            num_cross=num_cross+1;    
        end;
    end;
   
end;
