function [x_good,y_good]=find_good_pixel(RI,level)
    [m,n]=size(RI);
    x_good=[];
    y_good=[];
    for i=1:m
        cur_left=RI(i,1);
        if(cur_left>level*2 && cur_left<255-level*2)
           x_good=[x_good;i];
           y_good=[y_good,1];
        end
        
        cur_right=RI(i,n);
        if(cur_right>level*2 && cur_right<255-level*2)
           x_good=[x_good;i];
           y_good=[y_good,n];
        end
    end
    
    for j=1:n
        cur_top=RI(1,j);
        if(cur_top>level*2 && cur_top<255-level*2)
           x_good=[x_good;1];
           y_good=[y_good,j];
        end
        
        cur_bot=RI(m,j);
        if(cur_bot>level*2 && cur_bot<255-level*2)
           x_good=[x_good;m];
           y_good=[y_good,j];
        end
    end
end