function [RI,extract_bits]=general_extract(AI,u,v,base_pixels,a)
    [SI,extract_bits]=data_extraction(AI,u,v,base_pixels,a);
    [RI,extract_H]=expand_histogram(SI,extract_bits);
    len_H=numel(extract_H);
    extract_bits=extract_bits(len_H+1:end);

end