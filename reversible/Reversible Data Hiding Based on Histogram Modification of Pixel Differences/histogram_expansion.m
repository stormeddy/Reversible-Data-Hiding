function [RI]=histogram_expansion(TI,H,L)
    % recover original image according to H
    RI=TI;
    low_ind=find(TI<2^(L+1));
    high_ind=find(TI>255-2^(L+1));
    modify_area=find(H==1);
    
    low_modify=intersect(low_ind,modify_area);
    high_modify=intersect(high_ind,modify_area);
    RI(low_modify)=RI(low_modify)-2^L;
    RI(high_modify)=RI(high_modify)+2^L;


end