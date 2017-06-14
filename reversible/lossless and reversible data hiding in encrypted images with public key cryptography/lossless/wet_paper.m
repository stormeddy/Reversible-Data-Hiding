function [v]=wet_paper(stego_key,EI,add_bits,b)   
    
    r2=0.6;
    kavg=250;
    n=numel(b);
    beta=ceil(n*r2/kavg);
    
    n_arr=divide_bits(b,beta,stego_key);
    
    S=ksa(stego_key);
    I=zeros(n,ceil(n/beta));
    D=prga_crypt(I,S);
    D=mod(D,2);
    
    h=ceil(log2(n*r2/beta))+1;
    q=numel(add_bits)+beta*h;
    
    bp=b;
    i=1;
    
end