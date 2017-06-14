close all;
clearvars;

img='lena-64x64.tif';
I=imread(img);
% I=randi([0 255],40,40,'uint8');

% histogram shrink
delta=15;
% IT=hist_shrink(I,delta);
% figure(1)
% imshow(I)
% figure(2)
% imshow(IT)
% find(IT<delta)
% find(IT>255-delta)

% I=double(I);
% IT=double(IT);
% image encryption
% psnr(I,IT)
% ssim(I,IT)
[m,n]=size(I);
pa=rsa.Paillier;
EI=encryption_paillier(pa,I);
RI=decryption_paillier(pa,EI);
% data embedding
add_bits=randi([0 1],m*n/2,1);
AEI=reversible_embedding(pa,EI,add_bits,delta);
RRI=decryption_paillier(pa,AEI);
RRI=uint8(RRI);
imshow(RRI);
psnr(RRI,I)
ssim(RRI,I)
% RI=decryption_paillier(pa,AEI);
% % print_big_integer_matrix(EI);
% % RI==I
% 
% 
% 
% AEI=loss_embedding(pa,EI,add_bits);
% % print_big_integer_matrix(AEI);
% RRI=decryption_paillier(pa,AEI);
