function [FFRI]=filter_directly_decrypt_image2(RI,thres,permutation_key,encryption_key,u,v,msb)
    [m,n]=size(RI);
    RI=double(RI);
    FRI=RI;
    FFRI=FRI;
    for i=2:m-1
        for j=2:n-1
%             if (mod(i,4)==2 || mod(i,4)==3) && (mod(j,4)==2 || mod(j,4)==3)
                tmp=FRI(i-1:i+1,j-1:j+1);
                diff=abs(9*FRI(i,j)-sum(tmp(:)));
                if (FRI(i,j)==0 || FRI(i,j)==255) && diff>thres
                    t=tmp(:);
                    FFRI(i,j)=median([t(1:4);t(5:9)]);
                end
%             end
        end
    end
end