function [AI,num,ratio,base_pixels,a,b]=general_embed(I,add_bits,u,v)
    I=double(I);
    % shrink histogram
    [SI,H]=shrink_histogram(I);
    % length of location map
    len_H=numel(H);
    add_bits=[H(:);add_bits(:)];
    
    [AI,num,base_pixels,a,b]=data_embedding(SI,add_bits,u,v);
    
    num=num-len_H;
    ratio=num/numel(I);
end