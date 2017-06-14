function [AI1,extract_bits]=data_extraction_sample(AI2,RP,ref_l,ref_r)
    % embed bits from sample pixels and recover sample pixels    
    [m,n]=size(AI2);
    d_ref=ones(m,n)*300;
    for i=1:2:m
        for j=1:2:n
            d_ref(i,j)=AI2(i,j)-RP(i,j);
        end
    end
    
    extract_bits=[];
    modify_d_ref=d_ref;
    for i=1:2:m
        for j=1:2:n
            if d_ref(i,j)>ref_r
                modify_d_ref(i,j)=d_ref(i,j)-1;
                if d_ref(i,j)==ref_r+1
                    extract_bits=[extract_bits;1];
                end
            else if d_ref(i,j)<ref_l
                    modify_d_ref(i,j)=d_ref(i,j)+1;
                    if d_ref(i,j)==ref_l-1
                        extract_bits=[extract_bits;1];
                    end
                else
                    if d_ref(i,j)==ref_l || d_ref(i,j)==ref_r
                        extract_bits=[extract_bits;0];
                    end                 
                end
            end
        end
    end
    
    AI1=AI2;
    for i=1:2:m
        for j=1:2:n
            AI1(i,j)=RP(i,j)+modify_d_ref(i,j);
        end
    end

end