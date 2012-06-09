len=[116,154,261,181,140,117,64,93,291,107,244,105,157,182,54,75,73];


trna=[11,17];
bv_roc(trna,len(trna))
saveas(gcf,[pwd,'/','trna.jpg']); 
close

rrna=[1,2];(a(1:17)
bv_roc(rrna,len(rrna))
saveas(gcf,[pwd,'/','rrna.jpg']); 
close

rviral=[6];
bv_roc(rviral,len(rviral))
saveas(gcf,[pwd,'/','rviral.jpg']); 
close

snrna=[13,14,16];
bv_roc(snrna,len(snrna))
saveas(gcf,[pwd,'/','snrna.jpg']); 
close

ribo=[4,5,10,12];
bv_roc(ribo,len(ribo))
saveas(gcf,[pwd,'/','ribo.jpg']); 
close

cis=[3,7,15]
bv_roc(cis,len(cis))
saveas(gcf,[pwd,'/','cis.jpg']); 
close

srprna=[8,9]
bv_roc(srprna,len(srprna))
saveas(gcf,[pwd,'/','srprna.jpg']); 
close

%{
secis=7;
bv_roc(secis)
saveas(gcf,[pwd,'/','secis.jpg']); 
close

ires=3
bv_roc(t_rna)
saveas(gcf,[pwd,'/','ires.jpg']); 
close
%}







