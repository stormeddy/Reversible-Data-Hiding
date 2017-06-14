function [q_l,q_r]=find_two_peaks(d_interp)
    % find two peaks in the histogram of d_interp
    edges=[-255:1:255];
%     h=histogram(d_interp,edges);
%     
%     X = randn(1000,1);
% edges = [-5 -4 -2 -1 -0.5 0 0.5 1 2 4 5];
    counts = histcounts(d_interp,edges);
%     counts=h.Values;
%     close(h);
    
    [~,ind]=sort(counts,'descend');
    
%     counts(ind(1))
%     counts(ind(2))
    
    peak1_ind=edges(ind(1));
    peak2_ind=edges(ind(2));
    
    if peak1_ind<peak2_ind
        q_l=peak1_ind;
        q_r=peak2_ind;
    else
        q_l=peak2_ind;
        q_r=peak1_ind;
    end
    

end