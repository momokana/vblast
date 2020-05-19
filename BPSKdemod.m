function de = BPSKdemod(mo)
re=real(mo);
n=length(mo);
de=zeros(n,1);
for i=1:n
    if re(i)>0
        de(i)=1;
    end
end
