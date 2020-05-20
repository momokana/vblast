% m发射天线数
% n接受天线数
% L比特数

function [bitstr,zf_dete,mmse_dete,zf_ber,mmse_ber]=main(L,m,n,maxSNR,minSNR,SNRstep)
bitstr=produce_bitstr(L);
x=BPSKmod(bitstr);
x=reshape(x,m,L/m);     % 分组,每组长度L/m
snr=minSNR:SNRstep:maxSNR;   % 信噪比
I=length(snr);
va=zeros(I,1);
zf_dete=zeros(m,L/m);      % 检测信号
zf_ber=zeros(I,1);
mmse_dete=zf_dete;
mmse_ber=zf_ber;
H=(randn(n,m)+1i*randn(n,m))/sqrt(2);
for i=1:I
    %H=(randn(n,m)+1i*randn(n,m))/sqrt(2);
    va(i)=1/(2*10^(snr(i)/10));
    for j=1:L/m
        noise=sqrt(va(i))*(randn(n,1)+1i*randn(n,1));
        y=H*x(1:end,j)+noise;
        zf_dete(1:end,j)=zf_vblast(y,H);
        mmse_dete(1:end,j)=mmse_vblast(y,H,snr(i));
    end
    dzf=reshape(zf_dete,1,L);
    dmmse=reshape(mmse_dete,1,L);
    zf_ber(i)=sum(abs(dzf~=bitstr))/L;
    mmse_ber(i)=sum(abs(dmmse~=bitstr))/L;
end
semilogy(snr,zf_ber,'r');
hold on;
semilogy(snr,mmse_ber,'b');
xlabel('SNR/dB');
ylabel('BER');
title('BPSK调制,(4,4)MIMO系统中两种VBLAST检测算法的误码率与信噪比关系');
legend('ZF-BLAST','MMSE-VBLAST');


    