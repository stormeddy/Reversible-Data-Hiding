function [value]=fluctuation(h)
    [m,n]=size(h);
    value=0;
    hd=im2double(h);
    for u=2:m-1
        for v=2:n-1
            value=value+abs(hd(u,v)-(hd(u-1,v)+hd(u,v-1)+hd(u+1,v)+hd(u,v+1))/4);
        end
    end
end