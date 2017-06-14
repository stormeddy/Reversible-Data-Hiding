function [a,b]=find_max_min(diff)
    % actually only need a
    edges=0:1:255;
%     histogram(diff,edges)
    counts = histcounts(diff,edges);

    [~,ind]=sort(counts,'descend');
    a=edges(ind(1));
    b=edges(ind(end));
end