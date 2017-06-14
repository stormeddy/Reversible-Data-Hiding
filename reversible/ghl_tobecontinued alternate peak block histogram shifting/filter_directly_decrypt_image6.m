function [FRI]=filter_directly_decrypt_image6(RI,thres,permutation_key,encryption_key,u,v,msb,level)
    %filter the edge of the image
    [m,n]=size(RI);
    window_ver=floor(m/5);
    window_hor=floor(n/5);
    FRI=RI;
    
    for i=1:m
        half_window=floor(window_ver/2);
        if i>half_window && i<=m-half_window
            start=i-half_window;
        else if i<=half_window
            start=1;
            else
                start=m-window_ver+1;
            end
        end
        % left edge
        vec=RI(start:start+window_ver-1,1);
        cur=RI(i,1);

        if cur>=0 && cur<=2*level && ~is_lower_edge(vec)
            cur=255-level*2;
        else if cur>=255-level*2 && cur<=255 && is_lower_edge(vec)
                cur=2*level;
            end
        end
        FRI(i,1)=cur;
        
        % right edge
        vec=RI(start:start+window_ver-1,n);
        cur=RI(i,n);

        if cur>=0 && cur<=2*level && ~is_lower_edge(vec)
            cur=255-level*2;
        else if cur>=255-level*2 && cur<=255 && is_lower_edge(vec)
                cur=2*level;
            end
        end
        FRI(i,n)=cur;
        
    end
    
    
    for j=1:n
        half_window=floor(window_ver/2);
        
        if j>half_window && j<=n-half_window
            start=j-half_window;
        else if j<=half_window
            start=1;
            else
                start=n-window_hor+1;
            end
        end
        % top edge
        vec=RI(1,start:start+window_hor-1);
        cur=RI(1,j);

        if cur>=0 && cur<=2*level && ~is_lower_edge(vec)
            cur=255-level*2;
        else if cur>=255-level*2 && cur<=255 && is_lower_edge(vec)
                cur=2*level;
            end
        end
        FRI(1,j)=cur;
        
        % bottom edge
        vec=RI(m,start:start+window_hor-1);
        cur=RI(m,j);

        if cur>=0 && cur<=2*level && ~is_lower_edge(vec)
            cur=255-level*2;
        else if cur>=255-level*2 && cur<=255 && is_lower_edge(vec)
                cur=2*level;
            end
        end
        FRI(m,j)=cur;
        
    end

end