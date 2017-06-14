function [pf]=permute_within_block(f,encryption_key)
    [m,n]=size(f);
    % N=numel(f);
    
    S=ksa(encryption_key);
    KSTREAM=prga_crypt(f,S);
    [~,ind]=sort(KSTREAM(:));   
    
    pf=f(ind);
    pf=reshape(pf,m,n);
end