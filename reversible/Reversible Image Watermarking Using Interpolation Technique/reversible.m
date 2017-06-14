close all;
clearvars;
path='4.2.0';
for i=4:4
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    
    Ch1=R;
    Ch2=B;
    Ch3=G;
    
    add_bits=randi([0 1],numel(Ch3),1);
    
%     Ch3=imread('lena.tiff');% this image corresponds to the result in the paper for Lena image
%     Ch3_similar=imread('lena.pgm');
    
%     Ch3=imread('baboon.tiff');
%     Ch3=imread('plane.tiff');
%     Ch3=imread('lake.tiff');
    [AI,num,ratio,interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,add_bits);
    [RI,extract_bits]=general_extract(AI,interp_l,interp_r,ref_l,ref_r);
    
%     isequal(AI1,RAI1)
%     isequal(IP1,IP2)
%     
%     isequal(SI1,SI2)
    
    isequal(RI,Ch3)
    isequal(extract_bits,add_bits(1:num))
    

    num
    ratio
    psnr(uint8(AI),Ch3)  
%     diff=abs(AI-double(Ch3));
%     max(diff(:))

%     imshow(Ch3)
%     figure,imshow(Ch3_similar)
end