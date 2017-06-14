function [RI,extracted_bits]=general_extract(AEI,u,v,msb,permutation_key,encryption_key,data_hiding_key,left_shift)
    % data extraction
    [REI,extracted_bits]=data_extraction(AEI,data_hiding_key,u,v,left_shift);
    % expand histogram and extract location map
    [REI,extracted_H]=expand_hist(REI,u,v,extracted_bits,left_shift);
    lenH=length(extracted_H);
    extracted_bits=extracted_bits(lenH+1:end);
    % decrypt with encryption_key
    RJI=encrpyt_in_block_level(REI,encryption_key,u,v,msb);
    % reverse scramble
    RI=reverse_permute_with_key(RJI,permutation_key,u,v);

end