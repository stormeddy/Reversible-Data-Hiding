function [ICh3]=inter_channel_interpolation_sample(Ch3,Ch1,Ch2,N)
    % modified to 8 neighbourhood pixels if not on the borders
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
    
    
    for i=[1,ver_max]
        for j=1:2:hor_max
            c1=Ch1(i,j);
            c2=Ch2(i,j);
            if i==1
                if j==1
                    % left-top corner
%                     C1=[Ch1(i,j+1),Ch1(i+1,j)];
%                     C2=[Ch2(i,j+1),Ch2(i+1,j)];
%                     C3=[Ch3(i,j+1),Ch3(i+1,j)];
                      C1=[Ch1(i,j+1),Ch1(i+1,j),Ch1(i+1,j+1)];
                      C2=[Ch2(i,j+1),Ch2(i+1,j),Ch2(i+1,j+1)];
                      C3=[Ch3(i,j+1),Ch3(i+1,j),Ch3(i+1,j+1)];
                else if j==n
                        % right-top corner
                        C1=[Ch1(i,j-1),Ch1(i+1,j),Ch1(i+1,j-1)];
                        C2=[Ch2(i,j-1),Ch2(i+1,j),Ch2(i+1,j-1)];
                        C3=[Ch3(i,j-1),Ch3(i+1,j),Ch3(i+1,j-1)];
                    else
                        % top edge
                        C1=[Ch1(i,j-1),Ch1(i,j+1),Ch1(i+1,j),Ch1(i+1,j-1),Ch1(i+1,j+1)];
                        C2=[Ch2(i,j-1),Ch2(i,j+1),Ch2(i+1,j),Ch2(i+1,j-1),Ch2(i+1,j+1)];
                        C3=[Ch3(i,j-1),Ch3(i,j+1),Ch3(i+1,j),Ch3(i+1,j-1),Ch3(i+1,j+1)];
                    end
                end
            else if i==m
                    if j==1
                        % left-bottom corner
                        C1=[Ch1(i-1,j),Ch1(i,j+1),Ch1(i-1,j+1)];
                        C2=[Ch2(i-1,j),Ch2(i,j+1),Ch2(i-1,j+1)];
                        C3=[Ch3(i-1,j),Ch3(i,j+1),Ch3(i-1,j+1)];
                    else if j==n
                            % right-bottom corner
                            C1=[Ch1(i-1,j),Ch1(i,j-1),Ch1(i-1,j-1)];
                            C2=[Ch2(i-1,j),Ch2(i,j-1),Ch2(i-1,j-1)];
                            C3=[Ch3(i-1,j),Ch3(i,j-1),Ch3(i-1,j-1)];
                        else
                            % bottom edge
                            C1=[Ch1(i,j-1),Ch1(i,j+1),Ch1(i-1,j),Ch1(i-1,j-1),Ch1(i-1,j+1)];
                            C2=[Ch2(i,j-1),Ch2(i,j+1),Ch2(i-1,j),Ch2(i-1,j-1),Ch2(i-1,j+1)];
                            C3=[Ch3(i,j-1),Ch3(i,j+1),Ch3(i-1,j),Ch3(i-1,j-1),Ch3(i-1,j+1)];
                        end
                    end
                end
            end
            ICh3(i,j)=inter_channel_local_estimation(c1,c2,C1,C2,C3,N);
        end
    end
    
    for i=3:2:m-1
        for j=[1,hor_max]
            c1=Ch1(i,j);
            c2=Ch2(i,j);
            if j==1
                % left edge
                C1=[Ch1(i-1,j),Ch1(i,j+1),Ch1(i+1,j),Ch1(i-1,j+1),Ch1(i+1,j+1)];
                C2=[Ch2(i-1,j),Ch2(i,j+1),Ch2(i+1,j),Ch2(i-1,j+1),Ch2(i+1,j+1)];
                C3=[Ch3(i-1,j),Ch3(i,j+1),Ch3(i+1,j),Ch3(i-1,j+1),Ch3(i+1,j+1)];
            else if j==n
                    % right edge
                    C1=[Ch1(i-1,j),Ch1(i,j-1),Ch1(i+1,j),Ch1(i-1,j-1),Ch1(i+1,j-1)];
                    C2=[Ch2(i-1,j),Ch2(i,j-1),Ch2(i+1,j),Ch2(i-1,j-1),Ch2(i+1,j-1)];
                    C3=[Ch3(i-1,j),Ch3(i,j-1),Ch3(i+1,j),Ch3(i-1,j-1),Ch3(i+1,j-1)];
                end
            end
            ICh3(i,j)=inter_channel_local_estimation(c1,c2,C1,C2,C3,N);
            
        end
        
    end
    
    for i=3:2:m-1
        for j=3:2:n-1
            % inner sample pixels
           c1=Ch1(i,j);
           c2=Ch2(i,j);
           C1=[Ch1(i-1,j),Ch1(i,j-1),Ch1(i,j+1),Ch1(i+1,j),Ch1(i-1,j-1),Ch1(i+1,j-1),Ch1(i-1,j+1),Ch1(i+1,j+1)];
           C2=[Ch2(i-1,j),Ch2(i,j-1),Ch2(i,j+1),Ch2(i+1,j),Ch2(i-1,j-1),Ch2(i+1,j-1),Ch2(i-1,j+1),Ch2(i+1,j+1)];
           C3=[Ch3(i-1,j),Ch3(i,j-1),Ch3(i,j+1),Ch3(i+1,j),Ch3(i-1,j-1),Ch3(i+1,j-1),Ch3(i-1,j+1),Ch3(i+1,j+1)];
           ICh3(i,j)=inter_channel_local_estimation(c1,c2,C1,C2,C3,N);
        end        
    end
end