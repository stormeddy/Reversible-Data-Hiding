function [EI]=encrpyt_in_block_level(I,encryption_key,u,v,msb)
    [m,n]=size(I);
    hor_num=floor(m/u);
    ver_num=floor(n/v);
    
    T=zeros(hor_num,ver_num);
    S=ksa(encryption_key);
    KSTREAM=prga_crypt(T,S);
    
    EI=I;
    for i=1:numel(KSTREAM)
        % encrypt m MSB
        str=bitshift(bitshift(KSTREAM(i),msb-8),8-msb);
        [xi,yi] = ind2sub([hor_num,ver_num],i);
        tmp=I((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v);
        EI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v)=bitxor(tmp,str);
    end
end