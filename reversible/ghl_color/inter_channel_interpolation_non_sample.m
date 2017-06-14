function [ICh3]=inter_channel_interpolation_non_sample(Ch3,Ch1,Ch2,N)
    Ch1=double(Ch1);
    Ch2=double(Ch2);
    Ch3=double(Ch3);
    ICh3=Ch3;
    
    [m,n]=size(Ch1);

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
          c1=Ch1(i,j);
          c2=Ch2(i,j);
          C1=[Ch1(i,j-1),Ch1(i,j+1)];
          C2=[Ch2(i,j-1),Ch2(i,j+1)];
          C3=[ICh3(i,j-1),ICh3(i,j+1)];
          ICh3(i,j)=inter_channel_local_estimation(c1,c2,C1,C2,C3,N);
       end
    end
    
    % calculate interpolation pixels of first and last odd column
    for i=2:2:ver_max
       for j=[1,hor_max]
          c1=Ch1(i,j);
          c2=Ch2(i,j);
          C1=[Ch1(i-1,j),Ch1(i+1,j)];
          C2=[Ch2(i-1,j),Ch2(i+1,j)];
          C3=[ICh3(i-1,j),ICh3(i+1,j)];
          ICh3(i,j)=inter_channel_local_estimation(c1,c2,C1,C2,C3,N);
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
           c1=Ch1(i,j);
           c2=Ch2(i,j);
           C1=[Ch1(i-1,j-1),Ch1(i-1,j+1),Ch1(i+1,j-1),Ch1(i+1,j+1)];
           C2=[Ch2(i-1,j-1),Ch2(i-1,j+1),Ch2(i+1,j-1),Ch2(i+1,j+1)];
           C3=[ICh3(i-1,j-1),ICh3(i-1,j+1),ICh3(i+1,j-1),ICh3(i+1,j+1)];
           ICh3(i,j)=inter_channel_local_estimation(c1,c2,C1,C2,C3,N);
%            Ch3(i,j)=directional_interploation(Ch3(i-1,j-1),Ch3(i-1,j+1),Ch3(i+1,j-1),Ch3(i+1,j+1));           
       end
    end
    
    % 2)
    % even row and odd column    and     odd row and even column
    % direction 0 and 90
    for i=2:2:ver_max-1
       for j=3:2:hor_max-2
           c1=Ch1(i,j);
           c2=Ch2(i,j);
           C1=[Ch1(i-1,j),Ch1(i,j-1),Ch1(i,j+1),Ch1(i+1,j)];
           C2=[Ch2(i-1,j),Ch2(i,j-1),Ch2(i,j+1),Ch2(i+1,j)];
           C3=[ICh3(i-1,j),ICh3(i,j-1),ICh3(i,j+1),ICh3(i+1,j)];
           ICh3(i,j)=inter_channel_local_estimation(c1,c2,C1,C2,C3,N);
%            Ch3(i,j)=directional_interploation(Ch3(i-1,j),Ch3(i,j-1),Ch3(i,j+1),Ch3(i+1,j));           
       end
    end
    
    for i=3:2:ver_max-2
       for j=2:2:hor_max-1
           c1=Ch1(i,j);
           c2=Ch2(i,j);
           C1=[Ch1(i-1,j),Ch1(i,j-1),Ch1(i,j+1),Ch1(i+1,j)];
           C2=[Ch2(i-1,j),Ch2(i,j-1),Ch2(i,j+1),Ch2(i+1,j)];
           C3=[ICh3(i-1,j),ICh3(i,j-1),ICh3(i,j+1),ICh3(i+1,j)];
           ICh3(i,j)=inter_channel_local_estimation(c1,c2,C1,C2,C3,N);
%            Ch3(i,j)=directional_interploation(Ch3(i-1,j),Ch3(i,j-1),Ch3(i,j+1),Ch3(i+1,j));           
       end
    end


end