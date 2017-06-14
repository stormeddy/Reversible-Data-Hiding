close all;
clearvars;

permutation_key='0ahUKEwjPxaD8krTPAhVs_4MKHUY';
encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';

u=4;
v=4;
msb=1;
abso_path='D:\Matlab\image_database\image_gray\image_gray';
img_num=1338;
psnr_ucid_one_level=zeros(img_num,1);
N=img_num;
for i=1:N
    path=[abso_path,num2str(i),'.tif'];
    I=imread(path);
    [m,n]=size(I);
    
    add_bits=randi([0 1],numel(I),1);
    % embed bits
    [AEI,ratio,num]=general_embed(I,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key);
    if ratio<0
        continue;
    end
    REI=AEI;
    
    % decrypt with encryption_key
    RJI=encrpyt_in_block_level(REI,encryption_key,u,v,msb);
    % reverse scramble
    RI=reverse_permute_with_key(RJI,permutation_key,u,v);
    
    psnr_ucid_one_level(i)=psnr(double(RI),double(I));
end
% save('psnr_ucid_one_level.mat','psnr_ucid_one_level');