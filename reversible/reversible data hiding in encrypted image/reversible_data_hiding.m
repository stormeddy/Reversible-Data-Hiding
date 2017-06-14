close all;
clearvars;
encryption_key='matlab2dfbe56d4';
I=imread('lena.pgm');
[m,n]=size(I);

% image encryption
EI=my_crypt_rc4(I,encryption_key);

% data embedding
data_hiding_key='howing-incorrect-resu';
block_size=13;
% in case m or n cannot be divided by block_size
hor_num=floor(n/block_size);
ver_num=floor(m/block_size);
add_bits=randi([0 1],hor_num*ver_num,1);% hor_num*ver_num: the maximum number of addtional bits

AEI=my_data_embedding(EI,data_hiding_key,add_bits,block_size);


% data extraction and image recovery
[RI,extraction]=data_image_extraction(AEI,encryption_key,data_hiding_key,block_size);

% directly decrypted image
II=my_crypt_rc4(AEI,encryption_key);

% figure(1)
% imshow(I)
% 
% figure(2)
% imshow(EI)
% 
% figure(3)
% imshow(II)
% 
% figure(4)
% imshow(RI)

I=double(I);
II=double(II);
RI=double(RI);

% ssim(II,I)
psnr(II,I)


% ssim(RI,I)
% psnr(RI,I)
result=numel(add_bits)/numel(I)
reversibility=1-(numel(find(RI~=I)))/numel(I)
error_ind=find(add_bits~=extraction);
error_rate=numel(error_ind)/numel(add_bits)
% figure
% rectangle('Position',[1 1 512 512])
% 
% pixel_ind=find(I~=RI);
% [x,y]=ind2sub(size(I),pixel_ind);
% plot(x,y,'s','markersize',4);
% set(gca,'XAxisLocation','top');
% set(gca,'YDir','reverse');