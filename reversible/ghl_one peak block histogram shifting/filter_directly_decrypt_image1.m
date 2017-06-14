function [FFRI]=filter_directly_decrypt_image1(RI,thres,permutation_key,encryption_key,u,v,msb)
    [m,n]=size(RI);
    RI=double(RI);
    FLAG=zeros(m,n);
%     hor_num=floor(m/u);
%     ver_num=floor(n/v);
    for i=2:m-1
        for j=2:n-1
%             if (mod(i,4)==2 || mod(i,4)==3) && (mod(j,4)==2 || mod(j,4)==3)
                tmp=RI(i-1:i+1,j-1:j+1);
                diff=abs(9*RI(i,j)-sum(tmp(:)));
                if diff>thres
                    FLAG(i,j)=1;
                end
%             end
        end
    end
    [PFLAG]=permute_with_key(FLAG,permutation_key,u,v);
    RI=uint8(RI);
    [JI]=permute_with_key(RI,permutation_key,u,v);
    EI=encrpyt_in_block_level(JI,encryption_key,u,v,msb);
    
    for i=1:m
        for j=1:n
            if(PFLAG(i,j)==1)
                if mod(EI(i,j),2)==0 && EI(i,j)~=0
                    EI(i,j)=EI(i,j)-1;
                else if mod(EI(i,j),2)==1 && EI(i,j)~=255
                        EI(i,j)=EI(i,j)+1;
                    end
                end
            end
        end
    end
    RJI=encrpyt_in_block_level(EI,encryption_key,u,v,msb);
    FRI=reverse_permute_with_key(RJI,permutation_key,u,v);
    
    FFRI=FRI;
    for i=2:m-1
        for j=2:n-1
%             if (mod(i,4)==2 || mod(i,4)==3) && (mod(j,4)==2 || mod(j,4)==3)
                tmp=FRI(i-1:i+1,j-1:j+1);
                diff=abs(9*FRI(i,j)-sum(tmp(:)));
                if diff>thres
                    FFRI(i,j)=median(tmp(:));
                end
%             end
        end
    end
end