function [RI,extract_H]=expand_histogram(SI,extract_bits)
    % extract location map and expand histogram together
    [m,n]=size(SI);
    H=[];
    RI=SI;
    ind=1;
    for y=1:n
        for x=1:m
            cur=SI(x,y);
            if cur==254 || cur==1 || cur==255 || cur==0
                   if cur==254 && extract_bits(ind)==0
                       RI(x,y)=255;
                   else if cur==1 && extract_bits(ind)==0
                       RI(x,y)=0;
                       end
                   end
                   ind=ind+1;
            end
        end
    end
    extract_H=extract_bits(1:ind-1);
end