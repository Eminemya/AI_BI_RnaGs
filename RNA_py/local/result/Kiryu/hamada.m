%{
%evalI
a=[117,184;184,196;230,213;247,221;271,233;295,250;314,285;336,406]
b=[149,189;205,205;225,214;260,229;287,249;314,273;329,339]
a(:,2)=0.9-(a(:,2)-167)/600;
b(:,2)=0.9-(b(:,2)-167)/600;
a(:,1)=0.6+(a(:,1)-113)/650;
b(:,1)=0.6+(b(:,1)-113)/650;
%}

%a:Centorid Alifold(new:al-ct)
%b:Centorid Alifold(new:al-mc)
colorss=['r-o';'r-o';'b-^';'b-^';'k-s';'k-s'];
figure
hold on
%Eval II:refer
a=[447,169;462,170;484,175;534,186;576,201;592,208;613,218;637,234;675,393]
b=[444,171;456,172;502,179;554,194;571,201;602,215;629,234;655,258;668,324]
a(:,2)=0.9-(a(:,2)-167)/600;
b(:,2)=0.9-(b(:,2)-167)/600;
a(:,1)=0.6+(a(:,1)-450)/650;
b(:,1)=0.6+(b(:,1)-450)/650;

plot(a(:,1),a(:,2),colorss(1,:))
plot(b(:,1),b(:,2),colorss(2,:))

a=load('better_en_roc_all');
b=load('roc_1_all');
plot([a(1:8,2);a(end,2);a(9:end-1,2)],[a(1:8,1);a(end,1);a(9:end-1,1)],colorss(3,:))
plot([b(1:8,2);b(end,2);b(9:end-1,2)],[b(1:8,1);b(end,1);b(9:end-1,1)],colorss(4,:))


%Eval II:prob
a=[111,174;131,176;172,190;222,224;248,229;280,249;309,269;347,307]
b=[105,176;142,182;197,202;218,213;262,241;303,267;328,295;362,344]
a(:,2)=0.7-(a(:,2)-167)/600;
b(:,2)=0.7-(b(:,2)-167)/600;
a(:,1)=0.5+(a(:,1)-113)/650;
b(:,1)=0.5+(b(:,1)-113)/650;
plot(a(:,1),a(:,2),colorss(5,:))
plot(b(:,1),b(:,2),colorss(6,:))



legend('Reference Aln+Centorid Alifold(new:al-ct)','Reference Aln+Centorid Alifold(new:al-mc)','Probcons Aln+RNAG ensemble','Probcons Aln+RNAG 1st cluster','Probcons Aln+Centorid Alifold(new:al-ct)','Probcons Aln+Centorid Alifold(new:al-mc)')
axis tight
xlabel('Positive Predictive Value(PPV)')
ylabel('Sensitivity(SEN)')

