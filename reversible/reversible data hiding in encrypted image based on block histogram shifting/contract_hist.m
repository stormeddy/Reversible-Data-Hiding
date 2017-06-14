function [H,EI]=contract_hist(EI,u,v)
    % generate location map and contract histogram together
    [m,n]=size(EI);
    hor_num=floor(m/u);
    ver_num=floor(n/v);
    H='';
    for i=1:hor_num*ver_num
       [xi,yi] = ind2sub([hor_num,ver_num],i);
       tmp=EI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v);
       
       for y=1:v
           for x=1:u
               cur=tmp(x,y);
               if cur==1 || cur==254
                  H=[H;'1'];
               else if cur==0 || cur==255
                       if cur==0
                           tmp(x,y)=1;
                       else
                           tmp(x,y)=254;
                       end
                       H=[H;'0'];
                   end
               end
           end
       end
       EI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v)=tmp;
    end
    H=str2num(H(:));
    
end