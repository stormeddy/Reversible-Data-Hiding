tic
close all;
clearvars;
path='4.2.0';
for i=4:4
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
%     R=I(:,:,1);
%     G=I(:,:,2);
%     B=I(:,:,3);
    
%     Ch1=R;
%     Ch2=G;
%     Ch3=B;
    N=[2 1 3];
    Ch1=I(:,:,N(1));
    Ch2=I(:,:,N(2));
    Ch3=I(:,:,N(3));
    
         M=[	
     0.4124564  0.3575761  0.1804375
     0.2126729  0.7151522  0.0721750    
     0.0193339  0.1191920  0.9503041];
    temp_M=M;
    % N用于确定通道间插值方式 N=[1 2 3]表示顺序为R G B
    for j=1:3
        M(:,j)=temp_M(:,N(j));
    end
    
    add_bits=randi([0 1],numel(Ch3),1);
    
    [AI,num,ratio,interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,Ch1,Ch2,M,add_bits,N);
    [RI,extract_bits]=general_extract(AI,interp_l,interp_r,ref_l,ref_r,Ch1,Ch2,M,N);
    
    
%     isequal(AI1,RAI1)
%     isequal(IP1,IP2)
%     
%     isequal(SI1,SI2)
    
    isequal(RI,Ch3)
    isequal(extract_bits,add_bits(1:num))
    
%     isequal(RP1,RP2)
%     isequal(extract_bits,add_bits2)
%     [AI1,num,ratio,interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,ICh3,add_bits);
    num
    ratio
    psnr(uint8(AI),Ch3)  
    toc
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