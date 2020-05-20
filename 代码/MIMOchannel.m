function [H,y] = MIMOchannel (m,n,x,SNR_dB)
H=randn(n,m)+1i*randn(n,m);
va=m/10^(SNR_dB/10);
z=sqrt(va)*(randn(n,1)+1i*randn(n,1));
y=H*x+z;

