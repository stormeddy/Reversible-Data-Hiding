close all;
clearvars;

% I=imread('cameraman.tif');
I=imread('lena.pgm');
figure(1)
imshow(I)

[m,n]=size(I);

% image scramble and encryption
jump=73;
u=4;
v=4;
msb=8;
encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';
add_bits=randi([0 1],numel(I),1);
[AEI,ratio,num]=geneal_embed(I,u,v,jump,msb,add_bits,encryption_key,data_hiding_key);

REI=AEI;

% decrypt with encryption_key
RJI=encrpyt_in_block_level(REI,encryption_key,u,v,msb);
% reverse scramble
RI=reverse_josephus_permute(RJI,encryption_key,jump,u,v);


figure(2)
imshow(RI)
psnr(double(RI),double(I))