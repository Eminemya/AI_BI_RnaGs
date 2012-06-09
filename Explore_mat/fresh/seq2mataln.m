function y=seq2mataln(place)
ind=find(place=='/');
tmp=textread(place,'%s','whitespace','\b');
seqq=tmp(2:2:length(tmp));
if(length(seqq)==2)
[GlobalScore, GlobalAlignment] = nwalign(seqq{1},seqq{2},'ALPHABET', 'NT');
dlmwrite([place(1:ind(end)) 'mat.aln'], GlobalAlignment([1,3],:),'')
else
qqq=multialign(seqq,'terminalGapAdjust',true)
dlmwrite([place(1:ind(end)) 'mat.aln'], qqq,'')
end

end