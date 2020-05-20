function [bitstr] = produce_bitstr(L)
bitstr=rand(1,L);
b=bitstr;
for i=1:L
    if b(i)>0.5
        bitstr(i)=1;
    else
        bitstr(i)=0;
    end
end
        
