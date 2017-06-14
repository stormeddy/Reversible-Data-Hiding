function [AI,ratio,ind,P]=data_embedding(I,add_bits)
    I=double(I);
    d=cal_diff(I);
    P=mode(d);% peak point
    
    
    sI=inverse_s_order(I);
    y=sI;
    N=numel(I);
    ind=1;
    for i=1:N
       if i==1 || d(i)<P 
            continue;
       else if d(i)>P
               if sI(i)>=sI(i-1)
                   y(i)=sI(i)+1;
               else
                   y(i)=sI(i)-1;
               end
           else
               if sI(i)>=sI(i-1)
                   y(i)=sI(i)+add_bits(ind);
               else
                   y(i)=sI(i)-add_bits(ind);
               end
               ind=ind+1;
           end
       end
            
    end
    
    [m,n]=size(I);
    AI=recover_inverse_s_order(y,m,n);
    ind=ind-1;
    ratio=ind/N;

end