function [c3]=inter_channel_local_estimation(c1,c2,C1,C2,C3,N)
    % estimate c3 according to c1,c2 and corresponding
    % four-pixel(diagonal) neighbourhood C1,C2 using C3
    
    % use Nearest-N-percent of distance-closest neighbourhood pixels to estimate
%     dist=((C1-c1).^2+(C2-c2).^2).^0.5;
%     min_dist=min(dist);
%     upper_limit_dist=(1+N/100)*min_dist;
%     ind=find(dist<=upper_limit_dist);


    % use Nearest-N-percent of angluar-closest neighbourhood pixels to estimate
    % 修改了c3=mean(NC3)，但对结果没有影响
    if c1==0 && c2==0
%         c3=mean(C3);
        if numel(C3)==4
            c3=directional_interploation(C3(1),C3(2),C3(3),C3(4));
        else
            c3=mean(C3);
        end
        return
    end
    
    n=numel(C1);
    angle=ones(n,1)*180;
    for i=1:n
        if C1(i)==0 && C2(i)==0
            continue;
        end
        angle(i)=acosd((C1(i)*c1+C2(i)*c2)/sqrt(c1^2+c2^2)/sqrt(C1(i)^2+C2(i)^2));
    end
    
    min_angle=min(angle);
%     upper_limit_angle=(1+N/100)*min_angle;
    upper_limit_angle=N+min_angle;
    ind=find(angle<=upper_limit_angle);
    
    
%     O1=(C1-C2)/sqrt(2);
%     O2=(C1+C2-2*C3)/sqrt(6);
%     O3=(C1+C2+C3)/sqrt(3);
    
    
    % NC1,NC2 and NC3 are used to estimate c3
    NC1=C1(ind);
    NC2=C2(ind);
    NC3=C3(ind);
    [c3]=estimate_c3(NC1,NC2,NC3,c1,c2);
end