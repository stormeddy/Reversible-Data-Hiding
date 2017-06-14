function [EI,num,ratio,num_loc]=data_embedding(I,add_bits,thres)
    I=double(I);
    EI=I;
    [m,n]=size(I);
    % shrink histogram
    [I,location_map]=shrink_histogram(I,thres);
    % length of location map
    num_loc=numel(location_map);
    add_bits=[location_map(:);add_bits(:)];
    
    [IP]=calculate_interpolation_pixels(I);
    d_interp=I-IP;
    ind=1;
    % embed bits into embeddable pixels
    for i=1:m
        for j=1:n
            if mod(i,2)==1 && mod(j,2)==1
                continue;
            end
            if d_interp(i,j)>thres
                EI(i,j)=I(i,j)+thres+1;
            else if d_interp(i,j)<-thres
                    EI(i,j)=I(i,j)-thres-1;
                else
                    if d_interp(i,j)>0
                        EI(i,j)=IP(i,j)+2*d_interp(i,j)+add_bits(ind);
                    else
                        EI(i,j)=IP(i,j)+2*d_interp(i,j)-add_bits(ind);
                    end
                    ind=ind+1;
                end
            end
        end
    end
    
    % embed bits into reference pixels
    if mod(m,2)==0
       ref_ver_max=m-1;
    else
       ref_ver_max=m;
    end
    if mod(n,2)==0
        ref_hor_max=n-1;
    else
        ref_hor_max=n-2;
    end
    
    d_ref=zeros(m,n);
    for i=1:2:ref_ver_max
        for j=1:2:ref_hor_max
            d_ref(i,j)=I(i,j)-EI(i,j+1);
            if d_ref(i,j)>thres
                EI(i,j)=I(i,j)+thres+1;
            else if d_ref(i,j)<-thres
                    EI(i,j)=I(i,j)-thres-1;
                else
                    if d_ref(i,j)>0
                        EI(i,j)=EI(i,j+1)+2*d_ref(i,j)+add_bits(ind);
                    else
                        EI(i,j)=EI(i,j+1)+2*d_ref(i,j)-add_bits(ind);
                    end
                    ind=ind+1;
                end
            end
        end
    end
    num=ind-1-num_loc;
    ratio=num/m/n;
end