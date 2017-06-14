close all;
clearvars;
encryption_key='matlab2dfbe56d4';
I=imread('lena.pgm');

figure(1)
imshow(I)

[m,n]=size(I);

% image scramble and encryption
jump=13;
u=6;
v=6;
msb=1;
[EI,JI]=josephus_and_encrypt(I,encryption_key,jump,u,v,msb);

figure(2)
imshow(EI)

% generate location map and contract histogram
[H,CEI]=contract_hist(EI,u,v);
% find(EI==255)
% find(EI==0)


% data embedding
data_hiding_key='howing-incorrect-resu';
lenH=length(H);
add_bits=[H;randi([0 1],numel(I),1)];
[AEI,ind]=data_embedding(CEI,data_hiding_key,u,v,add_bits);
ratio=(ind-lenH)/numel(I);

figure(3)
imshow(AEI)

% data extraction
[REI,extracted_bits]=data_extraction(AEI,data_hiding_key,u,v);

isequal(extracted_bits,add_bits(1:ind))

% expand histogram and extract location map
[REI,extracted_H]=expand_hist(REI,u,v,extracted_bits);
isequal(extracted_H,H)
isequal(REI,EI)

% decryption and reverse scramble
[RI,RJI]=reverse_josephus_and_decrypt(REI,encryption_key,jump,u,v,msb);
isequal(RJI,JI)
isequal(RI,I)
error=find(RI~=I);

figure(4)
imshow(RI)