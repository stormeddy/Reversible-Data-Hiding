close all;
clearvars;
encryption_key='matlab2dfbe56d4';
I=imread('lena.pgm');
[m,n]=size(I);

% image encryption
EI=my_crypt_rc4(I,encryption_key);

% data embedding
data_hiding_key='howing-incorrect-resu';
M=3;
L=150;
S=3;
Np=cal_Np(M,L,S); 
N=m*n;
add_bits=randi([0 1],floor((N-Np)*S/L)-Np,1);
[AEI]=my_data_embedding(EI,data_hiding_key,add_bits,M,L,S);

ratio=(floor((N-Np)*S/L)-Np)/N;

% directly decrypted image (with only encrytion key)
II=my_crypt_rc4(AEI,encryption_key);

% data extraction with only data hiding key
[lenM,lenS,lenL,binM,binL,binS]=cal_len(M,L,S);
[extracted_add_bits]=extraction_data_hiding_key(AEI,data_hiding_key,lenM,lenL,lenS);

error_ind=find(add_bits~=extracted_add_bits);
error_rate=numel(error_ind)/numel(add_bits)

% data extraction with with both the keys
[RI,extracted_add_bits]=extraction_both_keys(AEI,encryption_key,data_hiding_key,lenM,lenL,lenS);
error_ind=find(add_bits~=extracted_add_bits);
error_rate=numel(error_ind)/numel(add_bits)
err_pixel=find(RI~=I);

a=RI(err_pixel);
b=I(err_pixel);
c=double(a)-double(b);

Q=quality_index(RI,I);

figure(1)
imshow(I)

figure(2)
imshow(RI)

figure(3)
imshow(II)

figure(4)
imshow(AEI)

I=double(I);
II=double(II);
RI=double(RI);

ssim(RI,I)
psnr(RI,I)


ssim(II,I)
psnr(II,I)


