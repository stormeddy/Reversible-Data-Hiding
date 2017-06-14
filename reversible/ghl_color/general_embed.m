function [AI2,num,ratio,interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,Ch1,Ch2,N,add_bits)
    Ch1=double(Ch1);
    Ch2=double(Ch2);
    Ch3=double(Ch3);
    % shrink histogram
    [SCh3,H]=shrink_histogram(Ch3);
    % length of location map
    len_H=numel(H);
    add_bits=[H(:);add_bits(:)];
    
    % interpolate non-sample pixels
    [IP]=inter_channel_interpolation_non_sample(SCh3,Ch1,Ch2,N);
    % embed bits into non-sample pixels
    [AI1,num1,interp_l,interp_r]=data_embedding_non_sample(SCh3,IP,add_bits);
    
%     isequal(SCh3(1:2:end,1:2:end),AI1(1:2:end,1:2:end))
    
%     [TIP]=inter_channel_interploation_non_sample(AI1,Ch1,Ch2,N);
%     isequal(TIP,IP)
%     isequal(SCh3(1:2:end,1:2:end),TIP(1:2:end,1:2:end))

    % interpolate sample pixels
%     [RP]=inter_channel_interploation_sample(Ch3,AI1,Ch2,N);  %wrong!
    [RP]=inter_channel_interpolation_sample(AI1,Ch1,Ch2,N);
    % embed bits into non-sample pixels
    [AI2,num2,ref_l,ref_r]=data_embedding_sample(AI1,RP,add_bits(num1+1:end));
    
%     add_bits2=add_bits(num1+1:num1+num2);
    
    num=num1+num2-len_H;
    ratio=num/numel(Ch3);
end