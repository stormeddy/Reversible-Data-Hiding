function [est_p]=cal_p(DI,orig_index,M)
    [m,n]=size(DI);
%     DI=double(DI);
    [i,j]=ind2sub([m,n],orig_index);
    
    if i==1
        up=DI(orig_index);
    else
        up=DI(i-1,j);
    end
    
    if i==m
        down=DI(orig_index);
    else
        down=DI(i+1,j);
    end
    
    if j==1
        left=DI(orig_index);
    else
        left=DI(i,j-1);
    end
    
    if j==n
        right=DI(orig_index);
    else
        right=DI(i,j+1);
    end
    
    t=2^M;
    est_p=(floor(up/t)+floor(down/t)+floor(left/t)+floor(right/t))/4*t+t/2;
end