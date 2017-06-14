function [RI,extract_bits]=general_extract(AI2,interp_l,interp_r,ref_l,ref_r,Ch1,Ch2,M,N)
    % interpolate sample pixels
%     [RP]=inter_channel_interploation_sample(AI2,Ch1,Ch2,N);
    [RP]=inter_channel_interpolation_sample(AI2,Ch1,Ch2,M,N);
    [AI1,extract_bits2]=data_extraction_sample(AI2,RP,ref_l,ref_r);
    
    % interpolate non-sample pixels
    [IP]=inter_channel_interpolation_non_sample(AI1,Ch1,Ch2,M,N);
    [SI,extract_bits1]=data_extraction_non_sample(AI1,IP,interp_l,interp_r);
    
    extract_bits=[extract_bits1;extract_bits2];

    % expand histogram
    [RI,extract_H]=expand_histogram(SI,extract_bits);
    len_H=numel(extract_H);
    extract_bits=extract_bits(len_H+1:end);
end