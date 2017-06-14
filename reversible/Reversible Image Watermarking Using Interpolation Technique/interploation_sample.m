function [ICh3]=interploation_sample(Ch3)
    
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
    
    
    for i=[1,ver_max]
        for j=1:2:hor_max
            if i==1
                if j==1
                    % left-top corner
                    ICh3(i,j)=floor((ICh3(i+1,j)+ICh3(i,j+1))/2);
                else if j==n
                        % right-top corner
                        ICh3(i,j)=floor((ICh3(i+1,j)+ICh3(i,j-1))/2);
                    else
                        % top edge
                        ICh3(i,j)=floor((ICh3(i+1,j)+ICh3(i,j-1)+ICh3(i,j+1))/3);
                    end
                end
            else if i==m
                    if j==1
                        % left-bottom corner
                        ICh3(i,j)=floor((ICh3(i-1,j)+ICh3(i,j+1))/2);
                    else if j==n
                            % right-bottom corner
                            ICh3(i,j)=floor((ICh3(i-1,j)+ICh3(i,j-1))/2);
                        else
                            % bottom edge
                            ICh3(i,j)=floor((ICh3(i-1,j)+ICh3(i,j-1)+ICh3(i,j+1))/3);
                        end
                    end
                end
            end
        end
    end
    
    for i=3:2:m-1
        for j=[1,hor_max]
            
            if j==1
                % left edge
                ICh3(i,j)=floor((ICh3(i-1,j)+ICh3(i+1,j)+ICh3(i,j+1))/3);
            else if j==n
                    % right edge
                    ICh3(i,j)=floor((ICh3(i-1,j)+ICh3(i+1,j)+ICh3(i,j-1))/3);
                end
            end            
        end
        
    end
    
    for i=3:2:m-1
        for j=3:2:n-1
            % inner sample pixels
           ICh3(i,j)=directional_interploation(ICh3(i-1,j),ICh3(i,j-1),ICh3(i,j+1),ICh3(i+1,j));   
        end        
    end
end