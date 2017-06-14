function [AI,num,base_pixels,a,b]=data_embedding(SI,add_bits,u,v)
    [m,n]=size(SI);
    
    ver_num=floor(m/u);
    hor_num=floor(n/v);
    
    base_pixels=zeros(ver_num*hor_num,1);
    base_ind=1;
    
    img_diff=[];
    
    for i=1:ver_num
        for j=1:hor_num
            tmp=SI((i-1)*u+1:i*u,(j-1)*v+1:j*v);
            tmp=tmp(:);
            [~,ind]=sort(tmp);
            
            med_ind=ind(ceil(u*v/2));
            base_pixels(base_ind)=med_ind;
            base_ind=base_ind+1;
            
            diff=abs(tmp-tmp(med_ind));
            diff(med_ind)=[];% remove base pixels
            img_diff=[img_diff;diff];
        end
    end

    [a,b]=find_max_min(img_diff);
    
    AI=SI;
    base_ind=1;
    add_ind=1;
    
    total_num=numel(add_bits);
    for i=1:ver_num
        for j=1:hor_num
            tmp=SI((i-1)*u+1:i*u,(j-1)*v+1:j*v);
            base_value=tmp(base_pixels(base_ind));
            for k=1:u*v
                if k==base_pixels(base_ind)
                    continue;
                end
                cur_diff=abs(tmp(k)-base_value);
                if cur_diff>a
                    if tmp(k)>base_value
                        tmp(k)=tmp(k)+1;
                    else
                        tmp(k)=tmp(k)-1;
                    end
                else if cur_diff==a
                        if add_bits(add_ind)==1
                            if tmp(k)>base_value
                                tmp(k)=tmp(k)+1;
                            else
                                tmp(k)=tmp(k)-1;
                            end
                        end
                        add_ind=add_ind+1;
                    end
                end
                
                
                if add_ind==total_num+1
                    num=add_ind-1;
                    return;
                end
            end
            AI((i-1)*u+1:i*u,(j-1)*v+1:j*v)=tmp;
            base_ind=base_ind+1;
            
            
        end
        
    end
    num=add_ind-1;
end