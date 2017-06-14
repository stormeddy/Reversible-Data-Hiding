close all;
clearvars;

% image encryption
img='lena.pgm';
% I=imread(img);
I=randi([0 255],2,2,'uint8');
imshow(I)
[m,n]=size(I);
pa=rsa.Paillier;
EI=encryption_paillier(pa,I);
RI=decryption_paillier(pa,EI);
% print_big_integer_matrix(EI);
% RI==I

% data embedding
add_bits=randi([0 1],m*n/2,1);
AEI=loss_embedding(pa,EI,add_bits);
% print_big_integer_matrix(AEI);
RRI=decryption_paillier(pa,AEI);
