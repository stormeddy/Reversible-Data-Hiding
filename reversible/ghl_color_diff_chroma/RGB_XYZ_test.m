clearvars
close all
RGB_1 = imread('peppers.png');
XYZ = rgb2xyz(RGB_1);
figure
imshowpair(RGB_1,XYZ,'montage');
title('Image in RGB Color Space (Left) and XYZ Color Space (Right)');

RGB_2=im2uint8(xyz2rgb(XYZ));
isequal(RGB_1,RGB_2)

% R_1=RGB_1(:,:,1);
% G_1=RGB_1(:,:,2);
% B_1=RGB_1(:,:,3);
% 
% R_2=RGB_2(:,:,1);
% G_2=RGB_2(:,:,2);
% B_2=RGB_2(:,:,3);

X=XYZ(:,:,1);
Y=XYZ(:,:,2);
Z=XYZ(:,:,3);