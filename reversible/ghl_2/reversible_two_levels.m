close all;
clearvars;

% I=imread('cameraman.tif');
I=imread('lena.pgm');
figure(1)
imshow(I)

[m,n]=size(I);

% image scramble and encryption
u=4;
v=4;
msb=8;
add_bits1=randi([0 1],numel(I),1);
permutation_key='0ahUKEwjPxaD8krTPAhVs_4MKHUY';
encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';
% embed bits level 1
[AEI1,ratio1,num1]=general_embed(I,u,v,msb,add_bits1,permutation_key,encryption_key,data_hiding_key);

% embed bits level 2
add_bits2=randi([0 1],numel(I),1);
[AEI2,ratio2,num2]=general_embed(AEI1,u,v,msb,add_bits2,permutation_key,encryption_key,data_hiding_key);
figure(2)
imshow(AEI2)
% extract bits level 2
[RI2,extracted_bits2]=general_extract(AEI2,u,v,msb,permutation_key,encryption_key,data_hiding_key);
% extract bits level 1
[RI1,extracted_bits1]=general_extract(RI2,u,v,msb,permutation_key,encryption_key,data_hiding_key);
isequal(RI1,I)

ratio=ratio1+ratio2
isequal([extracted_bits1;extracted_bits2],[add_bits1(1:num1);add_bits2(1:num2)])
