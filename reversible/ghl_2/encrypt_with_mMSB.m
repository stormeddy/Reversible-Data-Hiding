function [EI]=encrypt_with_mMSB(I,key,m)
    %   KSTREAM:key stream
    %   EI:encrypted image/
    %                     decrypted image(if I is encrypted image and key is the original key)
    S=ksa(key);
    KSTREAM=prga_crypt(I,S);
    KSTREAM=bitshift(bitshift(KSTREAM,m-8),8-m);
    EI=bitxor(I,KSTREAM);
end
