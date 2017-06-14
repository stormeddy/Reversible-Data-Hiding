function [RI]=decryption_paillier(pa,EI)
    m=EI.length;
    n=EI(1).length;
    RI=zeros(m,n);
    for i=1:m
        for j=1:n
            RI(i,j)=pa.Decryption(EI(i,j)).intValue();
        end
    end
end