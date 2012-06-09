%{
load bv.mat
color=['r.';'b.';'g.';'k.';'y.';'m.';'r*';'b*';'g*';'k*';'y*';'m*';'ro';'bo';'go';'ko';'yo';'mo']
hold on
for fam=1:17
hold on
for i=1:5
hold on
for ii=1:10
hold on
plot(mean(dis{ii}{5*(fam-1)+i}),var(dis{ii}{5*(fam-1)+i}),color(fam,:))
end
end
end
xlabel('bias')
ylabel('variance')
lenn=[116 ,154,261,181,140,117,64,93,291,107,244,105,157,182 ,54 ,75 ,73 ];
%}

%bv('/users/dwei/roc_norm/')
function dis=bv(place)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%1)transform from bracket to binary matrix
dis=cell(10,1);
for ii=1:85
pp=[place,num2str(ii-1),'/']
eval(['cd ',pp])
for ind_seq=1:10
truth=textread(['tru_str_',num2str(ind_seq)],'%s');
truth=truth{1};
N=length(truth);
truth(find(truth=='<'))='(';
truth(find(truth=='>'))=')';
tmp_st=textread(['project_',num2str(ind_seq),'.str'],'%s');
stru=cell(1,2001);
stru{1}=bra2list(truth);
for i=1:2000
stru{i+1}=bra2list(tmp_st{3*i});
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%2)distance from the reference structure
tmp=find_same(stru,2);
disp([ind_seq,ii])
dis{ind_seq}{ii}=tmp(1001:end);
end
end
eval(['cd ',place])
save bv.mat dis
end


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

function y=find_same(stru,mode)
if(mode==1)
%dist matrix
y=zeros(length(stru));
for i=1:length(stru)
    for j=i+1:length(stru)        
        y(i,j)=dist_ham(stru{i},stru{j});
    end
end
y=y+y';
elseif(mode==2)
y=zeros(1,length(stru)-1);
for i=2:length(stru)
y(i-1)=dist_ham(stru{1},stru{i});
end
end
end

function y=dist_ham(t1,t2)
he=unique([t1,t2]);
y=2*length(he)-length(t1)-length(t2);
end


