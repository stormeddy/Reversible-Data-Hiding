function [RI,extracted_bits]=general_extract(AEI,u,v,jump,msb,encryption_key,data_hiding_key)
    % data extraction
    [REI,extracted_bits]=data_extraction(AEI,data_hiding_key,u,v);
    % expand histogram and extract location map
    [REI,extracted_H]=expand_hist(REI,u,v,extracted_bits);
    lenH=length(extracted_H);
    extracted_bits=extracted_bits(lenH+1:end);
    % decrypt with encryption_key
    RJI=encrpyt_in_block_level(REI,encryption_key,u,v,msb);
    % reverse scramble
    RI=reverse_josephus_permute(RJI,encryption_key,jump,u,v);

end