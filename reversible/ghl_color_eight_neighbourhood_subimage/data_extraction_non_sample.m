function [RI,extract_bits]=data_extraction_non_sample(AI1,IP,interp_l,interp_r)
    % embed bits from sample pixels and recover sample pixels
    [m,n]=size(AI1);
    
    d_interp=AI1-IP;
    
    for i=1:2:m
        for j=1:2:n
            d_interp(i,j)=300;
        end        
    end
    
    extract_bits=[];
    modify_d_interp=d_interp;
    for i=1:m
        for j=1:n
            if mod(i,2)==1 && mod(j,2)==1
                continue;
            end
            if d_interp(i,j)>interp_r
                modify_d_interp(i,j)=d_interp(i,j)-1;
                if d_interp(i,j)==interp_r+1
                    extract_bits=[extract_bits;1];
                end
            else if d_interp(i,j)<interp_l
                    modify_d_interp(i,j)=d_interp(i,j)+1;
                    if d_interp(i,j)==interp_l-1
                        extract_bits=[extract_bits;1];
                    end
                else
                    if d_interp(i,j)==interp_l || d_interp(i,j)==interp_r
                        extract_bits=[extract_bits;0];
                    end                 
                end
            end
        end
    end
    
    modify_d_interp(modify_d_interp==300)=0;
    RI=modify_d_interp+IP;

end