function [EI]=my_crypt_rc4(I,key)
    %   KSTREAM:key stream
    %   EI:encrypted image/
    %                     decrypted image(if I is encrypted image and key is the original key)
    S=ksa(key);
    KSTREAM=prga_crypt(I,S);
    EI=bitxor(uint8(I),KSTREAM);
end