close all;
clearvars;

abso_path='D:\Matlab\image_database\test_grayscale_image\';
img_arr={'baboon.tiff','barbara.pgm','boat.pgm','crowd.tiff','plane.tiff',...
    'house.bmp','lena.tiff','peppers.tiff','lake.tiff','milkdrop.tiff','stream.tiff','tank.pgm'};
N=numel(img_arr);

encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';

result=zeros(N,50);
reversibility=zeros(N,50);
error_rate=zeros(N,50);
direct_psnr=zeros(N,50);
for i=1:N
    
    i
    path=[abso_path,char(img_arr(i))];
    I=imread(path);
    
    [m,n]=size(I);
    
    % image encryption
    EI=my_crypt_rc4(I,encryption_key);
    block_size=4;
    % data embedding
    while(true)
        if block_size>50
            break;
        end
        block_size
        % in case m or n cannot be divided by block_size
        hor_num=floor(n/block_size);
        ver_num=floor(m/block_size);
        add_bits=randi([0 1],hor_num*ver_num,1);% hor_num*ver_num: the maximum number of addtional bits
        
        AEI=my_data_embedding(EI,data_hiding_key,add_bits,block_size);
        
        
        % data extraction and image recovery
        [RI,extraction]=data_image_extraction(AEI,encryption_key,data_hiding_key,block_size);
        
        % directly decrypted image
        II=my_crypt_rc4(AEI,encryption_key);
        
        I=double(I);
        II=double(II);
        
        result(i,block_size)=numel(add_bits)/numel(I);
        reversibility(i,block_size)=1-(numel(find(RI~=I)))/numel(I);
        error_ind=find(add_bits~=extraction);
        error_rate(i,block_size)=numel(error_ind)/numel(add_bits);
        direct_psnr(i,block_size)=psnr(II,I);
        
        if reversibility(i,block_size)==1 && error_rate(i,block_size)==0
            break;
        end
        block_size=block_size+1;
    end
    
    
end
