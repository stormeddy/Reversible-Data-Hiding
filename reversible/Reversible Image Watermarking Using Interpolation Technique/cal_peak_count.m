function [res]=cal_peak_count(Ch3)
    Ch3=double(Ch3);
    [SCh3,~]=shrink_histogram(Ch3);
    [IP]=interpolation_non_sample(SCh3);
    d_interp=SCh3-IP;
    [m,n]=size(d_interp);
    d_interp(1:2:m,1:2:n)=300;

    edges=[-255:1:255];
    counts = histcounts(d_interp(d_interp~=300),edges);
    [sorted_counts,~]=sort(counts,'descend');
    res=sorted_counts(1)+sorted_counts(2);
end