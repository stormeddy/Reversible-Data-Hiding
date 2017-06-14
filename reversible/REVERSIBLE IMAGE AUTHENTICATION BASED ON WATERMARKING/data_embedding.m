function [AI,ratio,ind]=data_embedding(I,add_bits)
    % can be optimized by incorporating calculating difference and
    % histogram shifting
    AI=I;
    D=cal_diff(I);
    ind=1;
    [m,n]=size(I);
    col=floor(n/2);
    
    pk1=-1;
    pk2=1;
    for i=1:m
        for j=1:col
            if D(i,j)==pk2
                if add_bits(ind)==1
                    % shift right
                    AI(i,2*j-1)=I(i,2*j-1)+1;
                end
                ind=ind+1;
            else if D(i,j)==pk1
                    if add_bits(ind)==1
                        % shift left
                        AI(i,2*j-1)=I(i,2*j-1)-1;
                    end
                    ind=ind+1;
                else if D(i,j)>=pk2+1
                        AI(i,2*j-1)=I(i,2*j-1)+1;
                    else if D(i,j)<=pk1-1
                            AI(i,2*j-1)=I(i,2*j-1)-1;
                        end
                    end
                end
            end

        end
    end
    ind=ind-1;
    ratio=ind/(m*n);
end