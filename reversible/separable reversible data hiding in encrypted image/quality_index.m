function [Q]=quality_index(x,y)    
    % the universal quality index Q
    x=double(x(:));
    y=double(y(:));
    x_mean=mean(x);
    y_mean=mean(y);
    x_std=std(x);
    y_std=std(y);
    corr=corrcoef(x,y);
    Q=corr(2,1)*(2*x_mean*y_mean/(x_mean^2+y_mean^2))*(2*x_std*y_std/(x_std^2+y_std^2));
end