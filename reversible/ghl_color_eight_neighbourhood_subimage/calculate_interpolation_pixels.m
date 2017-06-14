function [IP]=calculate_interpolation_pixels(I)
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
    % first calculate interpolation pixels of odd line
    for i=1:2:ver_max
       for j=2:2:hor_max
          IP(i,j)=floor((IP(i,j-1)+IP(i,j+1))/2);
       end
    end
    % then calculate interpolation pixels of even line
    for i=2:2:ver_max-1
       for j=1:hor_max
           if mod(j,2)==0
               % use directional interpolation
               % Lixin Luo, Zhang Xiong. Reversible image watermarking using interpolation technique. 
               % IEEE Transaction on Information Forensics and Security 2010; 5(1): 187-193.
               d45=(I(i+1,j-1)+I(i-1,j+1))/2;
               d135=(I(i-1,j-1)+I(i+1,j+1))/2;
               miu=(I(i+1,j-1)+I(i-1,j+1)+I(i-1,j-1)+I(i+1,j+1))/4;
               sigma45=(I(i+1,j-1)-miu)^2+(I(i-1,j+1)-miu)^2+(d45-miu)^2;
               sigma135=(I(i-1,j-1)-miu)^2+(I(i+1,j+1)-miu)^2+(d135-miu)^2;
               if sigma45==0 && sigma135==0
                   w45=0.5;
                   w135=0.5;
               else
                   w45=sigma135/(sigma45+sigma135);
                   w135=sigma45/(sigma45+sigma135);
               end               
               IP(i,j)=floor(w45*d45+w135*d135);
           else
               IP(i,j)=floor((IP(i-1,j)+IP(i+1,j))/2);
           end
           
       end
    end

    % edge case
    % bottom line
    if mod(m,2)==0
        for j=1:2:hor_max
            IP(m,j)=I(m-1,j);
        end
        for j=2:2:hor_max-1
            IP(m,j)=floor((IP(m,j-1)+IP(m,j+1))/2);
        end
    end
    % right line
    if mod(n,2)==0
       for i=1:2:ver_max
           IP(i,n)=I(i,n-1);
       end
       for i=2:2:ver_max-1
           IP(i,n)=floor((IP(i-1,n)+IP(i+1,n))/2);
       end
    end
    % right bottom corner
    if mod(m,2)==0 && mod(n,2)==0
        IP(m,n)=IP(m-1,n-1);
    end
end