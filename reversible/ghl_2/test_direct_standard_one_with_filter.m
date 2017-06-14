close all;
clearvars;

permutation_key='0ahUKEwjPxaD8krTPAhVs_4MKHUY';
encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';

u=4;
v=4;
msb=1;
abso_path='D:\Matlab\image_database\test_grayscale_image\';
img_arr={'baboon.tiff','barbara.pgm','boat.pgm','crowd.pgm','plane.tiff',...
    'house.bmp','lena.tiff','peppers.tiff','lake.tiff','milkdrop.tiff','stream.tiff','tank.pgm'};
N=numel(img_arr);
psnr_standard_one_level=zeros(N,1);

for i=1:N
    path=[abso_path,img_arr{i}];
    I=imread(path);
%     I=imread('lena.pgm');
%     I=imread('49.pgm');
    [m,n]=size(I);
    
    add_bits=randi([0 1],numel(I),1);
    % embed bits
    [AEI,ratio,num]=general_embed(I,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key);
    REI=AEI;
    
    % decrypt with encryption_key
    RJI=encrpyt_in_block_level(REI,encryption_key,u,v,msb);
    % reverse scramble
    RI=reverse_permute_with_key(RJI,permutation_key,u,v);
    
    thres=1000;
    level=0;
    [FFRI]=filter_directly_decrypt_image3(RI,thres,permutation_key,encryption_key,u,v,msb,level);
    FFRI=uint8(FFRI);
    
    FGRI=uint8(FFRI);
    while true
        [FGRI,CHG]=filter_directly_decrypt_image4(FGRI,thres,permutation_key,encryption_key,u,v,msb,level);
        CHG;
        if ~CHG
            break;
        end
    end
    
    [FHRI]=filter_directly_decrypt_image6(FGRI,thres,permutation_key,encryption_key,u,v,msb,level);
    psnr_standard_one_level(i)=psnr(FHRI,I)
%     [FGRI]=filter_directly_decrypt_image4(FFRI,thres,permutation_key,encryption_key,u,v,msb,level);
%     psnr_standard_one_level(i)=psnr(FGRI,I)

end


DI=abs(double(I)-double(FHRI));
ind=find(DI==2);
diff=unique(DI);
[ind_x,ind_y]=ind2sub([m,n],ind);