function [c3]=inter_channel_local_estimation(c1,c2,C1,C2,C3,N)
    % estimate c3 according to c1,c2 and corresponding
    % four-pixel(diagonal) neighbourhood C1,C2 using C3
    
    % use Nearest-N-percent of closest neighbourhood pixels to estimate
    dist=((C1-c1).^2+(C2-c2).^2).^0.5;
    min_dist=min(dist);
    upper_limit_dist=(1+N/100)*min_dist;
    ind=find(dist<=upper_limit_dist);
    
    % NC1,NC2 and NC3 are used to estimate c3
    NC1=C1(ind);
    NC2=C2(ind);
    NC3=C3(ind);
    [c3]=estimate_c3(NC1,NC2,NC3,c1,c2);
end