function [KSTREAM]=prga_crypt(I,S)
%   Pseudo-random generation algorithm
%   number of pixels in image I indicates the length of KSTREAM
    [m, p]= size(I);
    i = 1;
    j = 1;
    n = numel(I);
    KSTREAM = zeros(1, n);
    for k = 1:n
        i = 1 + mod(i + 1, 256);
        j = 1 + mod(j + S(i), 256);
        tmp = S(i);
        S(i) = S(j);
        S(j) = tmp; %swap(S(i), S(j))
        Ks = 1 + mod(S(i) + S(j), 256);
        KSTREAM(k) = S(Ks);
    end
    KSTREAM = uint8(reshape(KSTREAM, m, p)); 
end