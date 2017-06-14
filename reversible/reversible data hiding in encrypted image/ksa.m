function [S]=ksa(key)
%   Key-scheduling algorithm (KSA)
    keylength = length(key);
    S = 0:255;
    j = 1;
    for i = 1:256
        j = 1 + mod(j + S(i) + key(1 + mod(i, keylength)), 256);
        tmp = S(i);
        S(i) = S(j);
        S(j) = tmp; %swap(S(i), S(j))
    end
end