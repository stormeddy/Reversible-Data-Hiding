function [REI,extracted_H]=expand_hist(REI,u,v,extracted_bits)
    % generate location map and contract histogram together
    [m,n]=size(REI);
    hor_num=floor(m/u);
    ver_num=floor(n/v);
    ind=1;
    for i=1:hor_num*ver_num
       [xi,yi] = ind2sub([hor_num,ver_num],i);
       tmp=REI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v);
       
       for y=1:v
           for x=1:u
               cur=tmp(x,y);
%                if cur==254 || cur==1 || cur==255 || cur==0
               if cur==1 
                   if extracted_bits(ind)==0
                       tmp(x,y)=0;
                   else
                       tmp(x,y)=1;
                   end
                   ind=ind+1;
               end
           end
       end
       REI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v)=tmp;
    end
    extracted_H=extracted_bits(1:ind-1);
    
end