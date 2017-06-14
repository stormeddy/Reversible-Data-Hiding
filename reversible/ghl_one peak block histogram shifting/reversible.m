% %% script version
% close all;
% clearvars;
% encryption_key='matlab2dfbe56d4';
% % I=imread('cameraman.tif');
% I=imread('lena.pgm');
% figure(1)
% imshow(I)
% 
% [m,n]=size(I);
% 
% % image scramble and encryption
% jump=73;
% u=4;
% v=4;
% msb=8;
% JI=josephus_permute(I,encryption_key,jump,u,v);
% 
% % image encryption
% EI=encrpyt_in_block_level(JI,encryption_key,u,v,msb);
% 
% figure(2)
% imshow(EI)
% 
% % generate location map and contract histogram
% [H,CEI]=contract_hist(EI,u,v);
% % find(EI==255)
% % find(EI==0)
% 
% 
% % data embedding
% data_hiding_key='howing-incorrect-resu';
% lenH=length(H);
% add_bits=[H;randi([0 1],numel(I),1)];
% [AEI,ind]=data_embedding(CEI,data_hiding_key,u,v,add_bits);
% ratio=(ind-lenH)/numel(I);
% 
% figure(3)
% imshow(AEI)
% 
% % data extraction
% [REI,extracted_bits]=data_extraction(AEI,data_hiding_key,u,v);
% 
% isequal(extracted_bits,add_bits(1:ind))
% 
% % expand histogram and extract location map
% [REI,extracted_H]=expand_hist(REI,u,v,extracted_bits);
% isequal(extracted_H,H)
% isequal(REI,EI)
% 
% % decrypt with encryption_key
% RJI=encrpyt_in_block_level(REI,encryption_key,u,v,msb);
% % reverse scramble
% RI=reverse_josephus_permute(RJI,encryption_key,jump,u,v);
% isequal(RJI,JI)
% isequal(RI,I)
% error=find(RI~=I);
% 
% figure(4)
% imshow(RI)

%% encapsulated version
% random select only one peak
close all;
clearvars;

% I=imread('cameraman.tif');
abso_path='D:\Matlab\image_database\image_gray\image_gray';
i=411;
path=[abso_path,num2str(i),'.tif'];
% I=imread('lena.pgm');
I=imread('D:\Matlab\image_database\test_grayscale_image\lena.tiff');

% I=imread(path);
figure(1)
imshow(I)

[m,n]=size(I);

% image scramble and encryption
u=4;
v=4;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                2;
msb=8;
add_bits=randi([0 1],numel(I),1);
permutation_key='0ahUKEwjPxaD8krTPAhVs_4MKHUY';
encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';
% embed bits
[AEI,ratio,num]=general_embed(I,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key);

% extract bits
[RI,extracted_bits]=general_extract(AEI,u,v,msb,permutation_key,encryption_key,data_hiding_key);
isequal(RI,I)
isequal(extracted_bits,add_bits(1:num))
ratio