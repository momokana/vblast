% BPSK调制
% 输入: bitstr 比特流
% 输出：bpsk 调制结果

function [bpsk] = BPSKmod(bitstr)
n=length(bitstr);
bpsk=ones(n,1);
for i=1:n
    if bitstr(i)==0
        bpsk(i)=-1;
    end
end
    
    

