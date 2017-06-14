close all;
clearvars;
encryption_key='matlab-program-is-result-in-one-function';
I=imread('lena.pgm');
[m,n]=size(I);

% image encryption
EI=my_crypt_rc4(I,encryption_key);

SI=uint8(abs(double(I)-double(EI)));

II=my_crypt_rc4(EI,encryption_key);
figure(1)
imshow(I)
figure(2)
imshow(EI)
figure(3)
imshow(SI)
figure(4)
imshow(II)

figure(5)
imhist(I)
figure(6)
imhist(EI)
figure(7)
imhist(SI)
figure(8)
imhist(II)