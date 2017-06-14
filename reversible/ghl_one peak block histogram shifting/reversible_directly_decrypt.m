close all;
clearvars;

% I=imread('cameraman.tif');
% I=imread('lena.pgm');
I=imread('bridge.tiff');
figure(1)
imshow(I)

[m,n]=size(I);

% image scramble and encryption
u=4;
v=4;
msb=1;
permutation_key='0ahUKEwjPxaD8krTPAhVs_4MKHUY';
encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';
add_bits=randi([0 1],numel(I),1);
% embed bits
[AEI,ratio,num]=general_embed(I,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key);
REI=AEI;

% decrypt with encryption_key
RJI=encrpyt_in_block_level(REI,encryption_key,u,v,msb);
% reverse scramble
RI=reverse_permute_with_key(RJI,permutation_key,u,v);

thres=1000;
level=0;
[FFRI]=filter_directly_decrypt_image3(RI,thres,permutation_key,encryption_key,u,v,msb,level);

figure(2)
imshow(RI)
psnr(RI,I)


figure(3)

FFRI=uint8(FFRI);
imshow(FFRI)
psnr(FFRI,I)

[FGRI]=filter_directly_decrypt_image4(FFRI,thres,permutation_key,encryption_key,u,v,msb,level);

figure(4)

imshow(FGRI)
psnr(FGRI,I)

% DI=abs(double(I)-double(FFRI));
% ind=find((DI~=0)&(DI~=1));
% diff=DI(ind);
% [ind_x,ind_y]=ind2sub([m,n],ind);
