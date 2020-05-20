% V-BLAST 检测
% 输入: R 接收信号（n*1）
%       H 转移矩阵 (n*m)
% 输出：a 检测信号（m*1)

function [a] = zf_vblast(y,H)
[n,m]=size(H);
a=zeros(m,1);
k_list=1:m;
r=y;
h=H;
G=pinv(H);
k=minnorm(G,k_list);
for i=1:m
    w=G(k,:);
    z=w*r;
    a(k)=BPSKdemod(z);
    r=r-BPSKmod(a(k)).*h(:,k);
    h(1:end,k)=zeros(n,1);
    G=pinv(h);
    k_list(find(k_list==k))=[];
    k=minnorm(G,k_list);
end