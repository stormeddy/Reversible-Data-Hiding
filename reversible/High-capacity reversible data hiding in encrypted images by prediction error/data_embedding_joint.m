function [AI,ratio,ind]=data_embedding_joint(EI,add_bits,data_hiding_key,input_n,input_t)
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
    
    N=numel(modify_ind);
    L=floor(N/input_n);
    for i=1:L
        if add_bits(i)==1
            for j=input_n*(i-1)+1:input_n*i
                % flip t-th bit
%                 t_bit=bitget(sel_pxl(permute_modify_ind(j)),input_t,'uint8');
%                 sel_pxl(permute_modify_ind(j))=bitset(sel_pxl(permute_modify_ind(j)),input_t,~t_bit,'uint8');
                sel_pxl(permute_modify_ind(j))=bitxor(sel_pxl(permute_modify_ind(j)),bitshift(1,input_t-1));
            end
        end
    end
    ind=L;
    ratio=L/m/n;
    AI(modify_ind)=sel_pxl(modify_ind);
end