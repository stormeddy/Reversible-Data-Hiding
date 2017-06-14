function [AI2,num2,ref_l,ref_r]=data_embedding_sample(AI1,RP,add_bits)
    % embed bits into sample pixels
    % 不同于A New Reversible Data Hiding Scheme with Improved Capacity 
    % Based on Directional Interpolation and Difference Expansion
    % 此处使用RP (RP通过使用邻域内包含额外信息的embeddable pixels来对reference pixels插值获得)
    
%     if mod(m,2)==0
%        ref_ver_max=m-1;
%     else
%        ref_ver_max=m;
%     end
%     if mod(n,2)==0
%         ref_hor_max=n-1;
%     else
%         ref_hor_max=n-2;
%     end
    
    [m,n]=size(AI1);
    d_ref=ones(m,n)*256;
    for i=1:2:m
        for j=1:2:n
            d_ref(i,j)=AI1(i,j)-RP(i,j);
        end
    end
    ind=1;
    [ref_l,ref_r]=find_two_peaks(d_ref(d_ref~=256));% left peak and right peak of sample pixels
    modify_d_ref=d_ref;
    for i=1:2:m
        for j=1:2:n
            if d_ref(i,j)>ref_r
                modify_d_ref(i,j)=d_ref(i,j)+1;
            else if d_ref(i,j)<ref_l
                    modify_d_ref(i,j)=d_ref(i,j)-1;
                else
                    if d_ref(i,j)==ref_l
                        modify_d_ref(i,j)=d_ref(i,j)+(-1)*add_bits(ind);
                        ind=ind+1;
                    else if d_ref(i,j)==ref_r
                            modify_d_ref(i,j)=d_ref(i,j)+add_bits(ind);
                            ind=ind+1;
                        end
                        % pixel q whose value ref_l < q < ref_r is not modified
                    end                    
                end
            end
        end
    end
    
%     modify_d_ref(modify_d_ref==256)=0;
    AI2=AI1;
    for i=1:2:m
        for j=1:2:n
            AI2(i,j)=RP(i,j)+modify_d_ref(i,j);
        end
    end
    num2=ind-1;


end