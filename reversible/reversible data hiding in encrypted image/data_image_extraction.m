function [I,extraction]=data_image_extraction(AEI,encryption_key,data_hiding_key,block_size)
    % AEI: encrytped image with addtional bits
    % I: original image
    % extraction: addtional bits
    
    AI=my_crypt_rc4(AEI,encryption_key);
    LAI=AI;
    HAI=AI;
    I=AI;
    
    S=ksa(data_hiding_key);
    dh_str=prga_crypt(AI,S);

    [m,n]=size(AI);
    hor_num=floor(n/block_size);
    ver_num=floor(m/block_size);
    extraction=zeros(hor_num*ver_num,1);
    
    for i=1:ver_num
        for j=1:hor_num
            temp=dh_str((i-1)*block_size+1:i*block_size,(j-1)*block_size+1:j*block_size);
            mid=median(temp(:));
            low=find(temp<=mid,floor(block_size*block_size/2));% block S0
            
            num=numel(low);
            [ti,tj]=ind2sub(size(temp),low);
            for k=1:num
                % flip 3 LSB to form H0                
                LAI((i-1)*block_size+ti(k),(j-1)*block_size+tj(k))=bitxor(LAI((i-1)*block_size+ti(k),(j-1)*block_size+tj(k)),7);
            end
            f0=fluctuation(LAI((i-1)*block_size+1:i*block_size,(j-1)*block_size+1:j*block_size));
                
            whole=1:block_size*block_size;
            high=setdiff(whole,low,'stable');% block S1
            num=numel(high);
            [ti,tj]=ind2sub(size(temp),high);
            for k=1:num
                % flip 3 LSB to form H1
                HAI((i-1)*block_size+ti(k),(j-1)*block_size+tj(k))=bitxor(HAI((i-1)*block_size+ti(k),(j-1)*block_size+tj(k)),7);
            end
            f1=fluctuation(HAI((i-1)*block_size+1:i*block_size,(j-1)*block_size+1:j*block_size));
            
            if f0<f1
                I((i-1)*block_size+1:i*block_size,(j-1)*block_size+1:j*block_size)=LAI((i-1)*block_size+1:i*block_size,(j-1)*block_size+1:j*block_size);
                extraction((i-1)*ver_num+j)=0;
            else
                I((i-1)*block_size+1:i*block_size,(j-1)*block_size+1:j*block_size)=HAI((i-1)*block_size+1:i*block_size,(j-1)*block_size+1:j*block_size);
                extraction((i-1)*ver_num+j)=1;
            end
        end
    end
end