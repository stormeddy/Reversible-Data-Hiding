function [AI,ratio,ind]=data_embedding_separate(EI,add_bits,data_hiding_key,input_t)
    AI=EI;
    [m,n]=size(EI);
    
    sel_pxl=-ones(m,n);
    for i=2:m-1
        if mod(i,2)==0
            start=2;
        else
            start=3;
        end
        for j=start:2:n-1
            sel_pxl(i,j)=EI(i,j);
        end
    end
    modify_ind=find(sel_pxl~=-1);
    
    S=ksa(data_hiding_key);
    KSTREAM=prga_crypt(modify_ind,S);
    [~,index]=sort(KSTREAM(:));
    permute_modify_ind=modify_ind(index);
    
%     N=numel(modify_ind);
%     L=floor(N/input_n);
    L=floor(numel(modify_ind)/1);
    for i=1:L
            sel_pxl(permute_modify_ind(i))=bitset(sel_pxl(permute_modify_ind(i)),input_t,add_bits(i));
    end
    ind=L;
    ratio=L/m/n;
    AI(modify_ind)=sel_pxl(modify_ind);
end