function [H_bits]=encode_location_map(H)
    [bin,num]=RunLength(H(:));
    N=numel(H);
    n=ceil(log2(N+1));% the number of bits to represent num(i) below
    H_bits=[];
    for i=1:numel(bin)
        H_bits=[H_bits de2bi(num(i),n,'left-msb')];
        H_bits=[H_bits bin(i)];
    end
    H_bits=H_bits';

end