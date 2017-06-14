function [judge,zero,full]=contains_jump(blk,level)
    [m,n]=size(blk);
    zero=[];
    full=[];
    
    min=255;
    max=0;
    for i=1:m*n
        pxl=blk(i);
        if pxl<min
            min=pxl;
        end
        if pxl>max
            max=pxl;
        end
        if pxl>=0 && pxl<=level*2
%         if pxl==0
            zero=[zero;i];
            
        end
        if pxl>=255-level*2 && pxl<=255
%         if pxl==255
            full=[full;i];
            
        end
    end
    judge=(max-min)>127;
end