function [insert_pos]=find_pos(a,k)
    % a: a sorted array
    % k: a value to be inserted
    % insert_pos: the position of insertion
    n=numel(a);
    lo=1;
    hi=n;
    if(k>a(n)) 
        insert_pos=n+1;
        return;
    end

    
    while lo<hi
        mid=floor((lo+hi)/2);
        if(a(mid)<k)
            lo=mid+1;
        else
            hi=mid;
        end
    end
    insert_pos=lo;
end