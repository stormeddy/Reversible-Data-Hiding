function [CI,H]=histogram_contraction(I,L)
    % H:location map
    [m,n]=size(I);
    H=zeros(m,n);
    CI=I;
    
    low_ind=find(I<2^L);
    CI(low_ind)=CI(low_ind)+2^L;
    H(low_ind)=1;
    
    high_ind=find(I>255-2^L);
    CI(high_ind)=CI(high_ind)-2^L;
    H(high_ind)=1;
end