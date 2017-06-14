function [AEI,ind]=data_embedding(EI,data_hiding_key,u,v,add_bits,left_shift)
[m,n]=size(EI);
hor_num=floor(m/u);
ver_num=floor(n/v);
len_key=length(data_hiding_key);

AEI=EI;
ind=1;
if left_shift==1
    % left histogram shifting
    for i=1:hor_num*ver_num
        [xi,yi] = ind2sub([hor_num,ver_num],i);
        tmp=EI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v);
        %        [ql,qr,ql_ind,qr_ind]=random_select(tmp,strcat(data_hiding_key,data_hiding_key(mod(i,len_key)+1)));
        [q,q_ind]=random_select_one(tmp,strcat(data_hiding_key,data_hiding_key(mod(i,len_key)+1)));
        
        for y=1:v
            for x=1:u
                cur_ind=sub2ind([u,v],x,y);
                if cur_ind==q_ind
                    continue;
                end
                cur=tmp(x,y);
                % only left shift
                if cur<q
                    tmp(x,y)=cur-1;                    
                else if cur==q
                        if add_bits(ind)==1
                            tmp(x,y)=cur-1;
                        end
                        ind=ind+1;                        
                    end
                end
            end
        end
        AEI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v)=tmp;
    end
else
    % right histogram shifting
    for i=1:hor_num*ver_num
        [xi,yi] = ind2sub([hor_num,ver_num],i);
        tmp=EI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v);
        %        [ql,qr,ql_ind,qr_ind]=random_select(tmp,strcat(data_hiding_key,data_hiding_key(mod(i,len_key)+1)));
        [q,q_ind]=random_select_one(tmp,strcat(data_hiding_key,data_hiding_key(mod(i,len_key)+1)));
        
        for y=1:v
            for x=1:u
                cur_ind=sub2ind([u,v],x,y);
                if cur_ind==q_ind
                    continue;
                end
                cur=tmp(x,y);
                % only right shift
                if cur>q
                    tmp(x,y)=cur+1;                    
                else if cur==q
                        if add_bits(ind)==1
                            tmp(x,y)=cur+1;
                        end
                        ind=ind+1;                        
                    end
                end
            end
        end
        AEI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v)=tmp;
    end
end

% actual length of add_bits
ind=ind-1;
end