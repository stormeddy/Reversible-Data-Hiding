function [AEI,ratio,num]=general_embed_level2(I,u,v,jump,msb,add_bits,encryption_key,data_hiding_key)
    % image scramble
    JI=josephus_permute(I,encryption_key,jump,u,v);
    % image encryption
    EI=encrypt_with_mMSB(JI,encryption_key,msb);
    % generate location map and contract histogram
    [H,CEI]=contract_hist(EI,u,v);
    
    lenH=length(H);
    add_bits=[H;add_bits];
    % data embedding
    [AEI,ind]=data_embedding(CEI,data_hiding_key,u,v,add_bits);
    % pure number of embedded bits
    num=ind-lenH;
    ratio=num/numel(I);
end