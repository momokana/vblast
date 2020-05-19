% m发射天线数
% n接受天线数
% L比特数

function [bitstr,dete,ber]=main(L,m,n,maxSNR,minSNR,SNRstep)
bitstr=produce_bitstr(L);
x=BPSKmod(bitstr);
x=reshape(x,m,L/m);     % 分组,每组长度L/m
snr=minSNR:SNRstep:maxSNR;   % 信噪比
I=length(snr);
va=zeros(I,1);
dete=zeros(m,L/m);      % 检测信号
ber=zeros(I,1);
for i=1:I
    H=(randn(n,m)+1i*randn(n,m))/sqrt(2);
    va(i)=1/(2*10^(snr(i)/10));
    for j=1:L/m
        noise=sqrt(va(i))*(randn(n,1)+1i*randn(n,1));
        y=H*x(1:end,j)+noise;
        dete(1:end,j)=vblast(y,H);
    end
    d=reshape(dete,1,L);
    ber(i)=sum(abs(d~=bitstr))/L;
end
plot(snr,ber);
xlabel('SNR/dB');
ylabel('BER');
title('BPSK调制,(4,4)MIMO系统中ZF-VBLAST检测算法的误码率与信噪比关系');
    