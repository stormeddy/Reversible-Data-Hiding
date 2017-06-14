close all;
clearvars;
encryption_key='matlab2dfbe56d4';
% I=imread('lena.pgm');
I=imread('lena.tiff');
[m,n]=size(I);

% image encryption
EI=my_crypt_rc4(I,encryption_key);

% data embedding
data_hiding_key='howing-incorrect-resu';
input_n=6;% in my experiment,input_n should be larger than 5 if input_t==6
          % for recovery with no error, the smaller input_t is, the larger the input_n is
input_t=6;
add_bits=randi([0 1],numel(I),1);
[AI,ratio,ind]=data_embedding_joint(EI,add_bits,data_hiding_key,input_n,input_t);

% image decryption
DI=my_crypt_rc4(AI,encryption_key);

% data extraction
[RI,extract_bits]=data_extraction_joint(DI,data_hiding_key,input_n,input_t);

figure(1)
imshow(I)

figure(2)
imshow(EI)

figure(3)
imshow(DI)

psnr(DI,I)
isequal(RI,I)
isequal(extract_bits,add_bits(1:ind))

diff=find(RI~=I)