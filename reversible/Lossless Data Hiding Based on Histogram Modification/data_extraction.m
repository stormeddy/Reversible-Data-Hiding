function [RI,extract_bits]=data_extraction(AI,P)
    AI=double(AI);
    ry=inverse_s_order(AI);
    rx=ry;
    N=numel(AI);
    [m,n]=size(AI);
    extract_bits=[];
    for i=2:N
       d=abs(ry(i)-rx(i-1));
       if d==P
           extract_bits=[extract_bits;0];
       else if d>P
               if d==P+1
                   extract_bits=[extract_bits;1];
               end
               if ry(i)<rx(i-1)
                   rx(i)=ry(i)+1;
               else if ry(i)>rx(i-1)
                       rx(i)=ry(i)-1;
                   end
               end
           end
       end
    end
    RI=recover_inverse_s_order(rx,m,n);
end