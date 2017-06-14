close all;
clearvars;
path='4.2.0';

test_N_psnr=zeros(7,10);
for i=1:7
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    i
    for j=1:1:10;
        Ch1=R;
        Ch2=B;
        Ch3=G;
        N=50*j;
        [ICh3]=inter_channel_interploation(Ch1,Ch2,Ch3,N);
        
        test_N_psnr(i,j)=psnr(uint8(ICh3),Ch3);
    end
    
    
end


% figure(1)
% imshow(I)
% 
% 
% figure(2)
% imshow(Ch3)
% figure(3)
% imshow(uint8(ICh3))
% 
% psnr(uint8(ICh3),Ch3)