function [AEI]=lossless_embedding(pa,EI,add_bits)
    import java.math.*
    import java.util.*
    
    m=EI.length;
    n=EI(1).length;
    nint=pa.n;
    nsq=pa.nsquare;
    AEI=javaArray('java.math.BigInteger',m,n);
    bitlength=floor(EI(1,1).toString.length()/2)-1;
    for i=1:m
        for j=1:n
            rand=Random();
            r=BigInteger(bitlength,rand);
            AEI(i,j)=EI(i,j).mod(nsq).multiply(r.modPow(nint,nsq)).mod(nsq);
        end
    end
    
end