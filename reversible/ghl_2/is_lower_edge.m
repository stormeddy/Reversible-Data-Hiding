function [lower]=is_lower_edge(vec)
    % test if edge is lower(<128)
    low=0;
    high=0;
    for i=1:numel(vec)
       if vec(i)<128
          low=low+1;
       else
           high=high+1;
       end
    end
    lower=low>high;
end