function [AEI,ratio,num]=general_embed(I,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key)
    % image scramble
    [JI]=permute_with_key(I,permutation_key,u,v);
    % image encryption
    EI=encrpyt_in_block_level(JI,encryption_key,u,v,msb);
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