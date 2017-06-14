function EI = endecrypt_rc4(I, key)

keylength = length(key);

[m,p] = size(I);

S = 0:255;

j = 1;

for i = 1:256

    j = 1 + mod(j + S(i) + key(1 + mod(i, keylength)), 256);
    tmp = S(i);
    S(i) = S(j);
    S(j) = tmp; %swap(S(i), S(j))
end
i = 1;
j = 1;
n = numel(I);
EI = zeros(1, n); % or EI = zeros(m, p), this enable us to avoid reshaping result
for k = 1:n
    i = 1 + mod(i + 1, 256);
    j = 1 + mod(j + S(i), 256);
    tmp = S(i);
    S(i) = S(j);
    S(j) = tmp; %swap(S(i), S(j))
    Ks = 1 + mod(S(i) + S(j), 256);
    EI(k) = bitxor(S(Ks), I(k));
end
EI = uint8(reshape(EI, m, p)); 