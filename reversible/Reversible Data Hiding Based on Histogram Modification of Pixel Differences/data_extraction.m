function [TI,extract_bits]=data_extraction(AI,L)
    AI=double(AI);
    ry=inverse_s_order(AI);
    rx=ry;
    N=numel(AI);
    [m,n]=size(AI);
    extract_bits=[];
%     for i=2:N
%        d=abs(ry(i)-rx(i-1));
%        if d==P
%            extract_bits=[extract_bits;0];
%        else if d>P
%                if d==P+1
%                    extract_bits=[extract_bits;1];
%                end
%                if ry(i)<rx(i-1)
%                    rx(i)=ry(i)+1;
%                else if ry(i)>rx(i-1)
%                        rx(i)=ry(i)-1;
%                    end
%                end
%            end
%        end
%     end


    for i=2:N
       d=abs(ry(i)-rx(i-1));
       if d<2^(L+1)
           if mod(d,2)==0
               extract_bits=[extract_bits;0];
           else
               extract_bits=[extract_bits;1];
           end
           if ry(i)<rx(i-1)
               rx(i)=ry(i)+ceil(d/2);
           else
               rx(i)=ry(i)-ceil(d/2);
           end
       else 
           if ry(i)<rx(i-1)
               rx(i)=ry(i)+2^L;
           else if ry(i)>rx(i-1)
                   rx(i)=ry(i)-2^L;
               end
           end

       end
    end
    
    
    TI=recover_inverse_s_order(rx,m,n);
end