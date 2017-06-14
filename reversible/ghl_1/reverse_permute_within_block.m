function [f]=reverse_permute_within_block(pf,encryption_key)
    [m,n]=size(pf);
    N=numel(pf);
    
    S=ksa(encryption_key);
    KSTREAM=prga_crypt(pf,S);
    [~,ind]=sort(KSTREAM(:));
    
    f=zeros(m,n);
    for i=1:N
       f(ind(i))=pf(i);
    end
    
end