function y=bra2list(bracket)
topstack = 0;
openstack = [];
y=[];
N=length(bracket);
for i=1:N
    if (bracket(i)=='(')
        topstack = topstack + 1;
        openstack(topstack) = i; 
    elseif (bracket(i)==')')
        y=[y,openstack(topstack)*N+i];
        topstack = topstack-1;
    end
end
end

