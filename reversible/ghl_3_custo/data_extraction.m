function [RI,extracted_bits]=data_extraction(AEI,data_hiding_key,u,v)
    
    [m,n]=size(AEI);
    hor_num=floor(m/u);
    ver_num=floor(n/v);
    len_key=length(data_hiding_key);
    
    RI=AEI;
    ind=1;
    extracted_bits=zeros(numel(AEI),1);
    temp_data_hiding_key=data_hiding_key;
     for i=1:hor_num*ver_num
       [xi,yi] = ind2sub([hor_num,ver_num],i);
       tmp=AEI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v);
       temp_data_hiding_key=strcat(temp_data_hiding_key,data_hiding_key(mod(i,len_key)+1));
       [ql,qr,ql_ind,qr_ind]=random_select(tmp,temp_data_hiding_key); 
       if ql==qr 
           % continue;
           for y=1:v
               for x=1:u
                   cur_ind=sub2ind([u,v],x,y);
                   if cur_ind==ql_ind || cur_ind==qr_ind
                       continue;
                   end
                   cur=tmp(x,y);
                   if cur<ql
                       if cur==ql-1
                           extracted_bits(ind)=1;
                           ind=ind+1;
                       end
                       tmp(x,y)=cur+1;
                   else if cur==ql
                          extracted_bits(ind)=0;
                          ind=ind+1;
                       end
                   end
               end
           end
       else

           for y=1:v
               for x=1:u
                   cur_ind=sub2ind([u,v],x,y);
                   if cur_ind==ql_ind || cur_ind==qr_ind
                       continue;
                   end
                   cur=tmp(x,y);
                   if cur<ql
                       if cur==ql-1
                           extracted_bits(ind)=1;
                           ind=ind+1;
                       end
                       tmp(x,y)=cur+1;
                   else if cur>qr
                           if cur==qr+1;
                               extracted_bits(ind)=1;
                               ind=ind+1;
                           end
                           tmp(x,y)=cur-1;
                       else if cur==ql || cur==qr
                               extracted_bits(ind)=0;
                               ind=ind+1;
                           end
                       end
                   end
               end
           end
       end
       RI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v)=tmp;
     end
    extracted_bits=extracted_bits(1:ind-1);
end