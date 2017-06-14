function [ql,qr,ql_ind,qr_ind]=random_select(tmp,data_hiding_key)
    % randomly select two different pixel values according to the data_hiding_key
    % and their indexes with the block 'tmp'
    S=ksa(data_hiding_key);
    KSTREAM=prga_crypt(tmp,S);
    [~,ind]=sort(KSTREAM(:));
    
    N=numel(tmp);
    i=1;
    
    % we cannot ensure different pixel values
    % an alternate solution is to use different embedding strategies when
    % qr==ql
    
    % ensure different pixel values
%     while(i<N&&tmp(ind(i))==tmp(ind(i+1)))
%         i=i+1;
%     end
    
%     if i==N
%         ql=tmp(ind(i));
%         qr=ql;
%         ql_ind=ind(i);
%         qr_ind=ind(i);
%         return; 
%     end
    ql=min(tmp(ind(i)),tmp(ind(i+1)));
    qr=max(tmp(ind(i)),tmp(ind(i+1)));
    
    if tmp(ind(i))<tmp(ind(i+1))
        ql_ind=ind(i);
        qr_ind=ind(i+1);
    else
        ql_ind=ind(i+1);
        qr_ind=ind(i);
    end

end