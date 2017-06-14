function [EI]=encryption_paillier(pa,I)
	import java.math.BigInteger
    [m,n]=size(I);
    EI=javaArray('java.math.BigInteger',m,n);
    
    for i=1:m
        for j=1:n
            EI(i,j)=pa.Encryption(BigInteger(num2str(I(i,j))));
        end
    end
end