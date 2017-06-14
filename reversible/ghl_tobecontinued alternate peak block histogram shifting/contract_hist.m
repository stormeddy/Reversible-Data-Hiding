function [H,EI]=contract_hist(EI,u,v,left_shift)
% generate location map and contract histogram together
[m,n]=size(EI);
hor_num=floor(m/u);
ver_num=floor(n/v);
H='';
if left_shift==1
    % left histogram contraction
    for i=1:hor_num*ver_num
        [xi,yi] = ind2sub([hor_num,ver_num],i);
        tmp=EI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v);
        % only contract 0
        for y=1:v
            for x=1:u
                cur=tmp(x,y);
                if cur==1
                    H=[H;'1'];
                else if cur==0
                        tmp(x,y)=1;
                        H=[H;'0'];
                    end
                end
            end
        end
        EI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v)=tmp;
    end
else
    % right histogram contraction
    for i=1:hor_num*ver_num
        [xi,yi] = ind2sub([hor_num,ver_num],i);
        tmp=EI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v);
        % only contract 0
        for y=1:v
            for x=1:u
                cur=tmp(x,y);
                if cur==254
                    H=[H;'1'];
                else if cur==255
                        tmp(x,y)=254;
                        H=[H;'0'];
                    end
                end
            end
        end
        EI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v)=tmp;
    end
end

H=str2num(H(:));

end