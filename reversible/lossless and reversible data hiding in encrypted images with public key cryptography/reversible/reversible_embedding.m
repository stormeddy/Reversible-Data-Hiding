function [AEI]=reversible_embedding(pa,EI,add_bits,delta)
    import java.math.*
    import java.util.*
    
    m=EI.length;
    n=EI(1).length;
    nint=pa.n;
    nsq=pa.nsquare;
    AEI=javaArray('java.math.BigInteger',m,n);
    bitlength=floor(EI(1,1).toString.length()/2)-1;
    add_ind=1;
    g=BigInteger('2');
    del=BigInteger(num2str(delta));
    for i=1:m
        for j=1:n
            if(mod(i+j,2)==1)
                rand=Random();
                r=BigInteger(bitlength,rand);
                
                if(add_bits(add_ind)=='0')
                    AEI(i,j)=EI(i,j).mod(nsq).multiply(g.modPow(nint.subtract(del),nsq)).multiply(r.modPow(nint,nsq)).mod(nsq);
                else
                    AEI(i,j)=EI(i,j).mod(nsq).multiply(g.modPow(del,nsq)).multiply(r.modPow(nint,nsq)).mod(nsq);
                end
                add_ind=add_ind+1;
            else
                AEI(i,j)=EI(i,j);
            end
        end
    end
    
end