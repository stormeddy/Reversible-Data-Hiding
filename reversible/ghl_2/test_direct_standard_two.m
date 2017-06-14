close all;
clearvars;

permutation_key='0ahUKEwjPxaD8krTPAhVs_4MKHUY';
encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';

u=4;
v=4;
msb=1;
abso_path='D:\Matlab\image_database\test_grayscale_image\';
img_arr={'baboon.tiff','barbara.pgm','boat.pgm','crowd.pgm','plane.tiff',...
    'house.bmp','lena.tiff','peppers.tiff','lake.tiff','milkdrop.tiff','stream.tiff','tank.pgm'};
N=numel(img_arr);
psnr_standard_two_level=zeros(N,1);

for i=1:N
    path=[abso_path,img_arr{i}];
    I=imread(path);
%     I=imread('lena.pgm');
%     I=imread('49.pgm');
    [m,n]=size(I);
    
    add_bits=randi([0 1],numel(I),1);
    % embed bits
    [AEI1,ratio,num]=general_embed(I,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key);
    
    [AEI2,ratio,num]=general_embed(AEI1,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key);
    REI2=AEI2;
    
    % decrypt with encryption_key
    RJI2=encrpyt_in_block_level(REI2,encryption_key,u,v,msb);
    % reverse scramble
    REI1=reverse_permute_with_key(RJI2,permutation_key,u,v);
    
    RJI1=encrpyt_in_block_level(REI1,encryption_key,u,v,msb);
    % reverse scramble
    RI=reverse_permute_with_key(RJI1,permutation_key,u,v);
    
    psnr_standard_two_level(i)=psnr(RI,I)

end