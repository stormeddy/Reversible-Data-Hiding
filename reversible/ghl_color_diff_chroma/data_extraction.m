function [RI,extracted_bits]=data_extraction(EI,thres,num_loc)
    [m,n]=size(EI);
    EI=double(EI);
    RI=EI;
    
    % extract bits from reference pixels and recover reference pixels
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
    
    extracted_bits1=zeros(m*n,1);
    ind1=1;
    d_ref=zeros(m,n);
    for i=1:2:ref_ver_max
        for j=1:2:ref_hor_max
            d_ref(i,j)=EI(i,j)-EI(i,j+1);
            if abs(d_ref(i,j))>2*thres+1
                if EI(i,j)>=EI(i,j+1)
                    RI(i,j)=EI(i,j)-thres-1;
                else
                    RI(i,j)=EI(i,j)+thres+1;
                end
            else
                if EI(i,j)>=EI(i,j+1)
                    RI(i,j)=EI(i,j+1)+floor(abs(d_ref(i,j))/2);
                else
                    RI(i,j)=EI(i,j+1)-floor(abs(d_ref(i,j))/2);
                end
                extracted_bits1(ind1)=mod(d_ref(i,j),2);
                ind1=ind1+1;
            end
        end
    end
    
    % extract bits from embeddable pixels and recover embeddable pixels
    [IP]=calculate_interpolation_pixels(RI);
%     [IP]=calculate_interpolation_pixels_full_directional(RI);
    d_interp=RI-IP;
    extracted_bits2=zeros(m*n,1);
    ind2=1;
    
    for i=1:m
        for j=1:n
            if mod(i,2)==1 && mod(j,2)==1
                continue;
            end
            if abs(d_interp(i,j))>2*thres+1
                if RI(i,j)>=IP(i,j)
                    RI(i,j)=RI(i,j)-thres-1;
                else
                    RI(i,j)=RI(i,j)+thres+1;
                end
            else
                if RI(i,j)>=IP(i,j)
                    RI(i,j)=IP(i,j)+floor(abs(d_interp(i,j))/2);
                else
                    RI(i,j)=IP(i,j)-floor(abs(d_interp(i,j))/2);
                end
            extracted_bits2(ind2)=mod(d_interp(i,j),2);
            ind2=ind2+1;
            end
            
        end
    end
    extracted_bits=[extracted_bits2(1:ind2-1);extracted_bits1(1:ind1-1)];
    
    location_map=extracted_bits(1:num_loc);
    [RI]=expand_histogram(RI,thres,location_map);
    extracted_bits=extracted_bits(num_loc+1:end);
end