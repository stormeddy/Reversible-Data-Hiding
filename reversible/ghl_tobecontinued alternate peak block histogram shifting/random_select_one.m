function [q,q_ind]=random_select_one(tmp,data_hiding_key)
    S=ksa(data_hiding_key);
    KSTREAM=prga_crypt(tmp,S);
    [~,ind]=sort(KSTREAM(:));
    
    N=numel(tmp);
    i=1;
    q=tmp(ind(i));
    q_ind=ind(i);

end