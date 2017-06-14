function [AI,ratio,ind,len_H]=general_data_embedding(I,add_bits,L)
    % shrink histogram
    [CI,H]=histogram_contraction(I,L);
    
    [H_bits]=encode_location_map(H);
    len_H=numel(H_bits);
    all_bits=[H_bits;add_bits];
    
    [AI,~,ind]=data_embedding(CI,all_bits,L);
    % the number of actual embedded bits should be subtracted by the length of H
    ind=ind-len_H;
    ratio=ind/numel(I);

end