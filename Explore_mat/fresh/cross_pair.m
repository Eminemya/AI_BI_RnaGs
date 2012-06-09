function T2=cross_pair(pair1,pair2)
T2=1;

if pair2(1)>pair1(1) && pair1(2)>pair2(1) && pair2(2)>pair1(2)
    T2=0;
elseif pair1(1)>pair2(1) && pair2(2)>pair1(1) && pair1(2)>pair2(2)
    T2=0;
end;

%T2=0  cross
%T2=1 no cross