reset(RandStream.getDefaultStream)
Dir='/home/donglai/code/workspace/RNA_GS/RNA_py/local/'
Dirs=cell(1,9);
for ii=1:9
Dirs{ii}=[Dir 'roc_10_' num2str(ii) '/'];
end


for i=0:1:84
tmpDirs=Dirs;
   for iii=1:9
      tmpDirs{iii}=[tmpDirs{iii} num2str(i) '/'];
      eval(['cd ' tmpDirs{iii}]);
      pwd
      %delete 00aln
      %delete 0.aln
      %eval(['delete seq_2.fa'])
   end   
a=textread('seq.fa','%s');
for ii=2:9
   %1) gen ran pair except first ii
   list=zeros(ii,10);
   list(:,1)=(1:ii)';
   count=2;
   while(count~=11)
      ww=sort(randsample(10,ii),'ascend');
      if(~any(sum(abs(list(:,1:count-1)-ww*ones(1,count-1)))==0))
         list(:,count)=ww;
         count=count+1;
      end
   end

   %2) cd into each trial and modify
   if(ii~=2)
      for iii=1:9
         tmpDirs{iii}=[tmpDirs{iii} num2str(ii) '/'];                 
      end
   else
     %tru_str_label
     for i=1:9
	movefile(['tru_str_' num2str(i)],['tru_' num2str(i)]);
     end     
   end   
   for iii=1:9
      eval(['cd ' tmpDirs{iii}]);
      %delete 00aln
      %delete 0.aln
      eval(['delete seq_' num2str(ii) '.fa'])
      for iiii=1:ii
         dlmwrite(['seq_' num2str(ii) '.fa'],a{2*list(iiii,iii+1)-1},'delimiter','','-append')
         dlmwrite(['seq_' num2str(ii) '.fa'],a{2*list(iiii,iii+1)},'delimiter','','-append')
      end         
      if(ii==2)
        for i=1:9
	    movefile(['tru_str_' num2str(i)],['tru_' num2str(i)]);
        end      
      end
   end   
end
end

