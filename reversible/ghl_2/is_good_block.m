function [res]=is_good_block(cur,level)
    [m,n]=size(cur);
    for i=1:m
        for j=1:n
            if(cur(i,j)<=level*2 || cur(i,j)>=255-level*2)
                res=false;
                return;
            end
        end
    end
    res=true;
end