function [ICh3]=interpolation_non_sample(Ch3)
    
    Ch3=double(Ch3);
    ICh3=Ch3;
    
    [m,n]=size(Ch3);

    if mod(m,2)==0
       ver_max=m-1;
    else
        ver_max=m;
    end
    if mod(n,2)==0
       hor_max=n-1; 
    else
       hor_max=n;
    end
    
    % calculate interpolation pixels of first and last odd row
    for i=[1,ver_max]
       for j=2:2:hor_max
          ICh3(i,j)=floor((ICh3(i,j-1)+ICh3(i,j+1))/2);
       end
    end
    
    % calculate interpolation pixels of first and last odd column
    for i=2:2:ver_max
       for j=[1,hor_max]
          ICh3(i,j)=floor((ICh3(i-1,j)+ICh3(i+1,j))/2);
       end
    end
    
    % if the last row or column is even one, interpolation is done through
    % copying
    if mod(m,2)==0
        ICh3(m,:)=ICh3(m-1,:);        
    end
    
    if mod(n,2)==0
        ICh3(:,n)=ICh3(:,n-1);
    end
    
    % right bottom corner
    if mod(m,2)==0 && mod(n,2)==0
        ICh3(m,n)=ICh3(m-1,n-1);
    end
    
    % calculate interpolation pixels of internal pixels
    
    % 1)
    % even row and even column
    % direction 45 and 135
    for i=2:2:ver_max-1
       for j=2:2:hor_max-1
           ICh3(i,j)=directional_interploation(ICh3(i-1,j-1),ICh3(i-1,j+1),ICh3(i+1,j-1),ICh3(i+1,j+1));           
       end
    end
    
    % 2)
    % even row and odd column    and     odd row and even column
    % direction 0 and 90
    for i=2:2:ver_max-1
       for j=3:2:hor_max-2
           ICh3(i,j)=directional_interploation(ICh3(i-1,j),ICh3(i,j-1),ICh3(i,j+1),ICh3(i+1,j));           
       end
    end
    
    for i=3:2:ver_max-2
       for j=2:2:hor_max-1
           ICh3(i,j)=directional_interploation(ICh3(i-1,j),ICh3(i,j-1),ICh3(i,j+1),ICh3(i+1,j));            
       end
    end


end