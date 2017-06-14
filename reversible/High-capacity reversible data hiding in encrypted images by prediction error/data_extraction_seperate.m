function [extract_bits]=data_extraction_seperate(AI,data_hiding_key,input_t)
    AI=double(AI);
    [m,n]=size(AI);
    sel_pxl=-ones(m,n);
    for i=2:m-1
        if mod(i,2)==0
            start=2;
        else
            start=3;
        end
        for j=start:2:n-1
            sel_pxl(i,j)=AI(i,j);
        end
    end
    modify_ind=find(sel_pxl~=-1);

    S=ksa(data_hiding_key);
    KSTREAM=prga_crypt(modify_ind,S);
    [~,index]=sort(KSTREAM(:));
    permute_modify_ind=modify_ind(index);

    L=floor(numel(modify_ind)/1);
    extract_bits=zeros(L,1);
    for i=1:L
        cur_ind=permute_modify_ind(i);
        extract_bits(i)=bitget(AI(cur_ind),input_t);
    end
end