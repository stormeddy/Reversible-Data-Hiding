function [AEI]=my_data_embedding(EI,data_hiding_key,add_bits,block_size)
    % EI: encrypted image
    % add_bits: additional bits
    % block_size: segmented nonoverlapping block's size
    
    % generate sequence according to the data hiding key
    S=ksa(data_hiding_key);
    dh_str=prga_crypt(EI,S);

    [m,n]=size(EI);
    hor_num=floor(n/block_size);
    ver_num=floor(m/block_size);

    AEI=EI;
    for i=1:ver_num
        for j=1:hor_num
            temp=dh_str((i-1)*block_size+1:i*block_size,(j-1)*block_size+1:j*block_size);
            mid=median(temp(:));
            low=find(temp<=mid,floor(block_size*block_size/2));% block S0
            if(add_bits((i-1)*ver_num+j)==0)                
                num=numel(low);
                [ti,tj]=ind2sub(size(temp),low);
                for k=1:num
    %               flip 3 LSB  
                    AEI((i-1)*block_size+ti(k),(j-1)*block_size+tj(k))=bitxor(AEI((i-1)*block_size+ti(k),(j-1)*block_size+tj(k)),7);
                end
            else
                whole=1:block_size*block_size;
                high=setdiff(whole,low,'stable');% block S1
                num=numel(high);
                [ti,tj]=ind2sub(size(temp),high);
                for k=1:num
    %               flip 3 LSB  
                    AEI((i-1)*block_size+ti(k),(j-1)*block_size+tj(k))=bitxor(AEI((i-1)*block_size+ti(k),(j-1)*block_size+tj(k)),7);
                end
            end
        end
    end
end