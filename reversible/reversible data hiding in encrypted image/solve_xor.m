function x=solve_xor(y,s)
    x=zeros(1,255);
    k=1;
    for i=0:255
       if(i-bitxor(i,s)==y)
           x(k)=i;
           k=k+1;
       else if(bitxor(i,s)-i==y)
           x(k)=i;
           k=k+1;
           end
       end
    end
end