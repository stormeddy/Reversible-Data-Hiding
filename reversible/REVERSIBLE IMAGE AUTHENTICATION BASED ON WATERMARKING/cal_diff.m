function D=cal_diff(I)
    % calculate difference image
    I=double(I);
    [m,n]=size(I);
    col=floor(n/2);
    D=zeros(m,col);
    for i=1:m
        for j=1:col
            D(i,j)=I(i,2*j-1)-I(i,2*j);            
        end
    end
    
end