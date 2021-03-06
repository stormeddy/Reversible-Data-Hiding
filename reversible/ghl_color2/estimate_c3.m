function [c3]=estimate_c3(NC1,NC2,NC3,c1,c2)
    % estimate according to the average chromaticity
    
    tmp=NC1+NC2+NC3; 
    if max(tmp)==0  % i.e. [0 0 0]
       c3=mean(NC3);
       return;
    end
    r3=NC3./tmp;
    mean_r3=mean(r3);
    
    if mean_r3==1   % e.g. [200 0 0]
       c3=mean(NC3);
       return;
    end
    % solve equation c3/(c1+c2+c3)=mean_r3
    c3=round((c1+c2)*mean_r3/(1-mean_r3));
    
    % if 0/0, c3 will be NaN
    if isnan(c3)
        c3=mean(NC3);
    end
end