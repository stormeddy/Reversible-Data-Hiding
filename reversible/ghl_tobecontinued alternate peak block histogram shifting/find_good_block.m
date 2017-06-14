function [x_good,y_good]=find_good_block(RI,u,v,level)
    [m,n]=size(RI);
    

    hor_num=floor(m/u);
    ver_num=floor(n/v);
    
    for i=1:hor_num*ver_num
        [x,y] = ind2sub([hor_num,ver_num],i);
        cur=RI((x-1)*u+1:x*u,(y-1)*v+1:y*v);
        if(is_good_block(cur,level))
           x_good=x;
           y_good=y;
           return
        end
    end
    x_good=0;
    y_good=0;
end