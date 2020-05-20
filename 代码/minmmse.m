function [k] = minmmse(G,H,k_list,snr_dB)
nsr=1/(10^(snr_dB/10));
f=G*H;
kz=length(k_list);
norm=zeros(1,kz);
for i=1:kz
    j=k_list(i);
    sq=f(j,j).^2;
    fsq=f(j,:)*f(j,:)';
    gsq=G(j,:)*G(j,:)';
    norm(i)=sq/(fsq-sq+nsr*gsq);
end
m=max(norm);
i=find(norm==m);
k=k_list(i);