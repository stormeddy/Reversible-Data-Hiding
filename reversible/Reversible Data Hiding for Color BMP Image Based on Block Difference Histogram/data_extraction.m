function [RI,extract_bits]=data_extraction(AI,u,v,base_pixels,a)
    % need modifying
    [m,n]=size(AI);
    
    ver_num=floor(m/u);
    hor_num=floor(n/v);
    
    RI=AI;
    base_ind=1;

    extract_bits=[];
    for i=1:ver_num
        for j=1:hor_num
            tmp=AI((i-1)*u+1:i*u,(j-1)*v+1:j*v);
            base_value=tmp(base_pixels(base_ind));
            for k=1:u*v
                if k==base_pixels(base_ind)
                    continue;
                end
                cur_diff=abs(tmp(k)-base_value);
                if cur_diff>a
                    if tmp(k)>base_value
                        tmp(k)=tmp(k)-1;
                    else
                        tmp(k)=tmp(k)+1;
                    end
                    if cur_diff==a+1
                        extract_bits=[extract_bits;1];
                    end
                else if cur_diff==a
                        extract_bits=[extract_bits;0];
                    end
                end
            end
            RI((i-1)*u+1:i*u,(j-1)*v+1:j*v)=tmp;
            base_ind=base_ind+1;
        end
        
    end

end