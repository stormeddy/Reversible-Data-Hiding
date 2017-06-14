function [lower]=is_lower(blk)
    % test if blk is lower(<128)
    cnt_low=0;
    cnt_high=0;
    for i=1:numel(blk)
       pxl=blk(i);
       if pxl<128
            cnt_low=cnt_low+1;
       else
           cnt_high=cnt_high+1;
       end
    end
    lower=cnt_low>cnt_high;
end