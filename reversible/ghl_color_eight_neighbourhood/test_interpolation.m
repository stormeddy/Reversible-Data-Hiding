close all;
clearvars;
I=imread('lena.pgm');
IP=calculate_interpolation_pixels(I);
IP=uint8(IP);

figure(1)
imshow(I)
figure(2)
imshow(IP)

psnr(IP,I)