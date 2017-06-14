function [RI,extract_bits]=data_extraction(AI)
    % can be optimized by incorporating calculating difference and
    % histogram shifting
    RI=AI;
    D=cal_diff(AI);
    extract_bits=[];
    [m,n]=size(AI);
    col=floor(n/2);
    
    pk1=-1;
    pk2=1;
    for i=1:m
        for j=1:col
            if D(i,j)==pk1 || D(i,j)==pk2
                extract_bits=[extract_bits;0];
            else if D(i,j)==pk1-1 || D(i,j)==pk2+1
                    extract_bits=[extract_bits;1];
                    if D(i,j)==pk1-1
                        RI(i,2*j-1)=AI(i,2*j-1)+1;
                    else
                        RI(i,2*j-1)=AI(i,2*j-1)-1;
                    end
                else if D(i,j)>pk2+1
                        RI(i,2*j-1)=AI(i,2*j-1)-1;
                    else if D(i,j)<=pk1-1
                            RI(i,2*j-1)=AI(i,2*j-1)+1;
                        end
                    end
                end
            end

        end
    end
end