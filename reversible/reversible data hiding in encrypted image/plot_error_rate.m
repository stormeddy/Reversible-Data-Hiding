close all;
clearvars;
blk=(8:4:40);
encryption_key='matlab-program-is-showing-incorrect-result-in-one-function';
I=imread('lena.pgm');
[m,n]=size(I);
data_hiding_key='howing-incorrect-resu';



error_rate=zeros(size(blk));
for i=1:numel(blk)
    
    

    % image encryption
    EI=my_crypt_rc4(I,encryption_key);

    % data embedding
    block_size=blk(i);
    % in case m or n cannot be divided by block_size
    hor_num=floor(n/block_size);
    ver_num=floor(m/block_size);
    add_bits=randi([0 1],hor_num*ver_num,1);% hor_num*ver_num: the maximum number of addtional bits

    AEI=my_data_embedding(EI,data_hiding_key,add_bits,block_size);


    % data extraction and image recovery
    [RI,extraction]=data_image_extraction(AEI,encryption_key,data_hiding_key,block_size);

    % directly decrypted image
%     II=my_crypt_rc4(AEI,encryption_key);



    error_ind=find(add_bits~=extraction);
    error_rate(i)=numel(error_ind)/numel(add_bits);
    
end
figure
plot(blk,error_rate,'bo-','markersize',8);
