function [AI,ratio,ind]=data_embedding(CI,add_bits,L)
    CI=double(CI);
    d=cal_diff(CI);
%     P=mode(d);% peak point
    
    
    sI=inverse_s_order(CI);
    y=sI;
    N=numel(CI);
    ind=1;
%     for i=1:N
%        if i==1 || d(i)<P 
%             continue;
%        else if d(i)>P
%                if sI(i)>=sI(i-1)
%                    y(i)=sI(i)+1;
%                else
%                    y(i)=sI(i)-1;
%                end
%            else
%                if sI(i)>=sI(i-1)
%                    y(i)=sI(i)+add_bits(ind);
%                else
%                    y(i)=sI(i)-add_bits(ind);
%                end
%                ind=ind+1;
%            end
%        end
%             
%     end

    for i=1:N
       if i==1
            continue;
       else if d(i)>=2^L
               if sI(i)>=sI(i-1)
                   y(i)=sI(i)+2^L;
               else
                   y(i)=sI(i)-2^L;
               end
           else
               if sI(i)>=sI(i-1)
                   y(i)=sI(i)+add_bits(ind)+d(i);
               else
                   y(i)=sI(i)-add_bits(ind)-d(i);
               end
               ind=ind+1;
           end
       end
            
    end
    
    [m,n]=size(CI);
    AI=recover_inverse_s_order(y,m,n);
    ind=ind-1;
    ratio=ind/N;

end