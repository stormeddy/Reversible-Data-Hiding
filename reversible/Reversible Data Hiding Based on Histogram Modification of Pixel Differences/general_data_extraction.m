function [RI,extract_bits]=general_data_extraction(AI,L,len_H)
    [TI,extract_bits]=data_extraction(AI,L);
    
    H_bits=extract_bits(1:len_H);
    H=decode_location_map(H_bits,AI);
    RI=histogram_expansion(TI,H,L);
    extract_bits=extract_bits(len_H+1:end);

end