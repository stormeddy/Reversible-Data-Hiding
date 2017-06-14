function [IP]=calculate_interpolation_pixels_full_directional(I)
    I=double(I);
    [m,n]=size(I);
    IP=I;
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
          IP(i,j)=floor((IP(i,j-1)+IP(i,j+1))/2);
       end
    end
    
    % calculate interpolation pixels of first and last odd column
    for i=2:2:ver_max
       for j=[1,hor_max]
          IP(i,j)=floor((IP(i-1,j)+IP(i+1,j))/2);
       end
    end
    
    % if the last row or column is even one, interpolation is done through
    % copy
    if mod(m,2)==0
        IP(m,:)=IP(m-1,:);        
    end
    
    if mod(n,2)==0
        IP(:,n)=IP(:,n-1);
    end
    
    % right bottom corner
    if mod(m,2)==0 && mod(n,2)==0
        IP(m,n)=IP(m-1,n-1);
    end
    
    % calculate interpolation pixels of internal pixels
    
    % 1)
    % even row and even column
    % direction 45 and 135
    for i=2:2:ver_max-1
       for j=2:2:hor_max-1
           IP(i,j)=directional_interploation(IP(i-1,j-1),IP(i-1,j+1),IP(i+1,j-1),IP(i+1,j+1));           
       end
    end
    
    % 2)
    % even row and odd column    and     odd row and even column
    % direction 0 and 90
    for i=2:2:ver_max-1
       for j=3:2:hor_max-2
           IP(i,j)=directional_interploation(IP(i-1,j),IP(i,j-1),IP(i,j+1),IP(i+1,j));           
       end
    end
    
    for i=3:2:ver_max-2
       for j=2:2:hor_max-1
           IP(i,j)=directional_interploation(IP(i-1,j),IP(i,j-1),IP(i,j+1),IP(i+1,j));           
       end
    end

%     % edge case
%     % bottom line
%     if mod(m,2)==0
%         for j=1:2:hor_max
%             IP(m,j)=I(m-1,j);
%         end
%         for j=2:2:hor_max-1
%             IP(m,j)=floor((IP(m,j-1)+IP(m,j+1))/2);
%         end
%     end
%     % right line
%     if mod(n,2)==0
%        for i=1:2:ver_max
%            IP(i,n)=I(i,n-1);
%        end
%        for i=2:2:ver_max-1
%            IP(i,n)=floor((IP(i-1,n)+IP(i+1,n))/2);
%        end
%     end
%     % right bottom corner
%     if mod(m,2)==0 && mod(n,2)==0
%         IP(m,n)=IP(m-1,n-1);
%     end
end