function [H]=decode_location_map(H_bits,I)
    % I provides the information of the size of the original H
    N=numel(I);
    n=ceil(log2(N+1));
    
    H_bits=H_bits';
    
    group_num=numel(H_bits)/(n+1);
    num=zeros(1,group_num);
    bin=zeros(1,group_num);
    for i=1:group_num
        num(i)=bi2de(H_bits(1+(i-1)*(n+1):i*(n+1)-1),'left-msb');
        bin(i)=H_bits(i*(n+1));        
    end
    
    H=RunLength(bin,num);
    H=reshape(H,size(I));
    


end