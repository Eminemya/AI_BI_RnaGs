function [MCC,SPE,SEN,CC,PPV]=sta(bp1,stru,bp_true,F,aln)


if(aln==1)
co=0;
for i=1:length(bp_true)
co=co+isthere(bp1,bp_true(i,:),1);
end
else
 
co=0;
for i=1:length(bp_true)
bp1(i)
co=co+isthere(bp1,bp_true(i,:),0);
end
end

TN=0;
TP=co;
FP=length(bp1)-co;
FN=length(bp_true)-co;

SEN=TP/(TP+FN);
SPE=TN/(TN+FP);
PPV=TP/(TP+FP);
CC=sqrt(SEN*PPV);

MCC=(TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));

end

function y=isthere(seq1,arr,aln)
y=0;
if(aln==1)
if(length(find(seq1(:,1)==arr(1)))==1)
if(seq1(find(seq1(:,1)==arr(1)),2)==arr(2))
    y=1;
end

else
    
end
end

end
