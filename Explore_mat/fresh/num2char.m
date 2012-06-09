function rr=num2char(tt,len)
rr='';
for i=1:len
rr=[rr '.'];
end
rr(find(tt==1))='(';
rr(find(tt==2))=')';
