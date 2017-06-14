function [RI,add_bits]=hist_extract(AI,max_px,min_px)
    N=numel(AI);
    add_bits=zeros(N,1);
    add_ind=1;
    
    
    
    RI=AI;
    
    % determine the histogram reverse shift direction
    if max_px<min_px
        for i=1:N
            if AI(i)==max_px+1
                add_bits(add_ind)=1;
                add_ind=add_ind+1;
            else if AI(i)==max_px
                    add_ind=add_ind+1;
                end
            end
        end
        between=(RI>max_px)&(RI<=min_px);
        RI(between)=RI(between)-1;
    else
        for i=1:N
            if AI(i)==max_px-1
                add_bits(add_ind)=1;
                add_ind=add_ind+1;
            else if AI(i)==max_px
                    add_ind=add_ind+1;
                end
            end
        end
        between=(RI>=min_px)&(RI<max_px);
        RI(between)=RI(between)+1;
    end
    
    add_bits=add_bits(1:add_ind-1);
    
    
end