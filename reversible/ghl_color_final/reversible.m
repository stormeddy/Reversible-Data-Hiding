close all;
clearvars;
path='4.2.0';
for i=7
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    
    Ch1=R;
    Ch2=B;
    Ch3=G;
    N=4;
    add_bits=randi([0 1],numel(Ch3),1);
    
    [AI,num,ratio,interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,Ch1,Ch2,N,add_bits);
    [RI,extract_bits]=general_extract(AI,interp_l,interp_r,ref_l,ref_r,Ch1,Ch2,N);
    
    

    
%     isequal(RI,Ch3)
%     isequal(extract_bits,add_bits(1:num))
%     
% 
%     num
    ratio
    psnr(uint8(AI),Ch3)  
%     diff=abs(AI-double(Ch3));
%     max(diff(:))
%     add_bits=randi([0 1],numel(Ch3),1);
%     [ICh3]=inter_channel_interploation(Ch1,Ch2,AI1,N);
%     [AI2,num,ratio,interp_l,interp_r,ref_l,ref_r]=general_embed(AI1,ICh3,add_bits);
%     num
%     ratio
%     psnr(uint8(AI2),Ch3)  
    
    
    % not so efficient
%     [ICh3]=calculate_interpolation_pixels(Ch3);
%     [AI,num,ratio,interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,ICh3,add_bits);
%     num
%     ratio
%     psnr(uint8(AI),Ch3)   
    
%     figure,imshow(uint8(AI))
    
end