close all;
origin=imread('Steganography_original.png');
figure
imshow(origin);
cat=bitand(origin,3)*(255/3);
figure
imshow(cat)