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
input_t=8;
add_bits=randi([0 1],numel(I),1);
[AI,ratio,ind]=data_embedding_separate(EI,add_bits,data_hiding_key,input_t);

% data extraction
[extract_bits]=data_extraction_seperate(AI,data_hiding_key,input_t);
% image decryption
DI=my_crypt_rc4(AI,encryption_key);
MI=medfilt2(DI);
MI2=medfilt2(MI);
psnr(DI,I)
psnr(MI,I)
psnr(MI2,I)


% image recovery
[RI]=image_recovery_separate(DI,data_hiding_key,input_t);
% 
figure(1)
imshow(I)

figure(2)
imshow(EI)

figure(3)
imshow(DI)

figure(4)
imshow(MI)
 
isequal(RI,I)
isequal(extract_bits,add_bits(1:ind))
% 
diff=find(RI~=I)
diff_bit=find(extract_bits~=add_bits(1:ind))