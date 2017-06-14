function [RI,extracted_bits]=data_extraction(AEI,data_hiding_key,u,v,left_shift)

[m,n]=size(AEI);
hor_num=floor(m/u);
ver_num=floor(n/v);
len_key=length(data_hiding_key);

RI=AEI;
ind=1;
extracted_bits=zeros(numel(AEI),1);
if left_shift==1
    % reverse left histogram shifting
    for i=1:hor_num*ver_num
        [xi,yi] = ind2sub([hor_num,ver_num],i);
        tmp=AEI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v);
        [q,q_ind]=random_select_one(tmp,strcat(data_hiding_key,data_hiding_key(mod(i,len_key)+1)));
        
        for y=1:v
            for x=1:u
                cur_ind=sub2ind([u,v],x,y);
                if cur_ind==q_ind
                    continue;
                end
                cur=tmp(x,y);
                if cur<q
                    if cur==q-1
                        extracted_bits(ind)=1;
                        ind=ind+1;
                    end
                    tmp(x,y)=cur+1;
                    
                else if cur==q
                        extracted_bits(ind)=0;
                        ind=ind+1;
                    end
                end
            end
        end
        RI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v)=tmp;
    end
else
    % reverse right histogram shifting
    for i=1:hor_num*ver_num
        [xi,yi] = ind2sub([hor_num,ver_num],i);
        tmp=AEI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v);
        [q,q_ind]=random_select_one(tmp,strcat(data_hiding_key,data_hiding_key(mod(i,len_key)+1)));
        
        for y=1:v
            for x=1:u
                cur_ind=sub2ind([u,v],x,y);
                if cur_ind==q_ind
                    continue;
                end
                cur=tmp(x,y);
                if cur>q
                    if cur==q+1
                        extracted_bits(ind)=1;
                        ind=ind+1;
                    end
                    tmp(x,y)=cur-1;
                    
                else if cur==q
                        extracted_bits(ind)=0;
                        ind=ind+1;
                    end
                end
            end
        end
        RI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v)=tmp;
    end
end

extracted_bits=extracted_bits(1:ind-1);
end