function [AI,max_px,min_px]=hist_embed_multi(I,add_bits)
    % consider only multiple pairs of maximum and minimum point
    [m,n]=size(I);
    [counts,binLocations] = imhist(I);
    
    % maximum k pairs of maximum and minimum point
    k=5;
    [~,max_ind]=max(counts);
    max_px=binLocations(max_ind);
    
    [sorted_counts,~]=sort(counts);
    sorted_counts=unique(sorted_counts);
    first_two_min=find(counts==min(counts));
    
    first
    
    b0_bin=first_two_min(1);
    b0=binLocations(b0_bin);
    b_right_bin=first_two_min(end);
    b_right=binLocations(b_right_bin);
    
    if(b0~=b_right)
        min_px=[b0;b_right];
    else
        min_px=[b0];
    end

    
    % find several pairs of maximum and minimum point
    while(true)
        pre_num=numel(min_px);
        for i=min_px(1)+2:min_px(end)-2

            pos=find_pos(min_px,i);

            if pos==1
                pre_bin=0;
            else
                pre_bin=min_px(pos-1)+1;
            end

            if pos==numel(min_px)+1
                aft_bin=257;
            else
                aft_bin=min_px(pos)+1;
            end

            bin_i=i+1;
            if( counts(bin_i)<=10 && (sum(counts(pre_bin+1:bin_i-1))>200 && sum(counts(bin_i+1:aft_bin-1))>200) )
                min_px=sort([min_px;i]);
            end

        end
        
        if numel(min_px)==pre_num || numel(min_px)==k;
            break;
        end
        
    end

        
%     index=find(sorted_counts<=10);
%     for i=2:numel(index)
%        po_counts=sorted_counts(i);
%        po_ind=find(counts==po_counts);
%        for j=1:numel(po_ind)
%            bin_ind=po_ind(j);
%            pos=find_pos(min_px);
%            if(sum(counts(b0+)))
%        end
%     end
    

   
    
    min_indexes=find(counts==min_val);
end