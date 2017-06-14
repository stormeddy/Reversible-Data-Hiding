function [n_arr]=divide_bits(b,beta,stego_key)
    % divide vector b into beta groups according to the stego key
    % each group contains floor(n/beta) or ceil(n/beta) bits
    n=numel(b);
    up=ceil(n/beta);
    down=floor(n/beta);
    n_arr=zeros(beta,1);
    
    
    if(up==down)
       for i=1:beta
           n_arr(i)=up;
       end
       return;
    end
    
    S=ksa(stego_key);
    I=zeros(beta,1);
    D=mod(prga_crypt(I,S),2);
    for i=1:beta
       if(D(i)==0)
           n_arr(i)=down;
       else
           n_arr(i)=up;
       end
    end
    rough_n=sum(n_arr);
    
    % regulate arr_n
    if(rough_n>n)        
        gap=rough_n-n;
        ind=1;
        while(gap>0)
            if(D(ind)==1)
                n_arr(ind)=down;
                gap=gap-1;
            end
            ind=ind+1;
        end
    else
        % rough_n<n      
        gap=n-rough_n;
        ind=1;
        while(gap>0)
            if(D(ind)==0)
                n_arr(ind)=up;
                gap=gap-1;
            end
            ind=ind+1;
        end
    end
    % res=sum(n_arr);    
end