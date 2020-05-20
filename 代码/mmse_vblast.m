% V-BLAST 检测
% 输入: R 接收信号（n*1）
%       H 转移矩阵 (n*m)
% 输出：a 检测信号（m*1)

function [a] = mmse_vblast(y,H,snr_dB)
[n,m]=size(H);
nsr=1/(10^(snr_dB/10));
a=zeros(m,1);
k_list=1:m;
r=y;
h=H;
G=H'*H+nsr*eye(m);
G=(inv(G))*H';
k=minmmse(G,h,k_list,snr_dB);
for i=1:m
    w=G(k,:);
    z=w*r;
    a(k)=BPSKdemod(z);
    r=r-BPSKmod(a(k)).*h(:,k);
    h(1:end,k)=zeros(n,1);
    G=h'*h+nsr*eye(m);
    G=(inv(G))*h';
    k_list(find(k_list==k))=[];
    k=minmmse(G,h,k_list,snr_dB);
end