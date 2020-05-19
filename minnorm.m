function [k] = minnorm(G,k_list)
kz=length(k_list);
norm=zeros(1,kz);
for i=1:kz
    norm(i)=G(k_list(i),:)*G(k_list(i),:)';
end
m=min(norm);
i=find(norm==m);
k=k_list(i);

    