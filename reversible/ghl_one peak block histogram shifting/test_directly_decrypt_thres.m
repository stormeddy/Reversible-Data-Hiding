close all;
clearvars;


abso_path='D:\Matlab\image_database\test_grayscale_image\';
img_arr={'lena.tiff'};
N=numel(img_arr);

permutation_key='0ahUKEwjPxaD8krTPAhVs_4MKHUY';
encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';

u=4;
v=4;
direct_psnr=zeros(10,8);
filter_direct_psnr1=zeros(10,8);
filter_direct_psnr2=zeros(10,8);

path=[abso_path,char(img_arr(1))];
I=imread(path);
[m,n]=size(I);
for msb=1:8
    msb
    % image scramble and encryption
    
    add_bits=randi([0 1],numel(I),1);
    % embed bits
    [AEI,ratio,num]=general_embed(I,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key);
    REI=AEI;
    
    % decrypt with encryption_key
    RJI=encrpyt_in_block_level(REI,encryption_key,u,v,ms b);
    % reverse scramble
    RI=reverse_permute_with_key(RJI,permutation_key,u,v);
    
    
    for j=1:10
        j
        direct_psnr(msb,j)=psnr(double(RI),double(I));
        thres=100*j;
        FRI1=filter_directly_decrypt_image1(RI,thres,permutation_key,encryption_key,u,v,msb);
        filter_direct_psnr1(msb,j)=psnr(double(FRI1),double(I));
        
        FRI2=filter_directly_decrypt_image2(RI,thres,permutation_key,encryption_key,u,v,msb);
        
        filter_direct_psnr2(msb,j)=psnr(double(FRI2),double(I));
    end
end



