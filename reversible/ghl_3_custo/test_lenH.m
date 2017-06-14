close all;
clearvars;


abso_path='D:\Matlab\image_database\test_grayscale_image\';
img_arr={'baboon.tiff','barbara.pgm','boat.pgm','crowd.tiff','plane.tiff',...
    'house.bmp','lena.tiff','peppers.tiff','lake.tiff','milkdrop.tiff','stream.tiff','tank.pgm'};
N=numel(img_arr);

u_arr=[2,3,4,5,6,7,8];
v_arr=[2,3,4,5,6,7,8];
M=numel(u_arr);

len=zeros(N,M);
for j=1:M
    j
    u=u_arr(j);
    v=v_arr(j);
for i=1:N
    % I=imread('lena.pgm');
    i
    path=[abso_path,char(img_arr(i))];
    I=imread(path);
   
    
    [m,n]=size(I);
    
    % image scramble and encryption
    
    msb=8;
    add_bits=randi([0 1],numel(I),1);
    permutation_key='0ahUKEwjPxaD8krTPAhVs_4MKHUY';
    encryption_key='matlab2dfbe56d4';
    data_hiding_key='howing-incorrect-resu';
    % embed bits
    [JI]=permute_with_key(I,permutation_key,u,v);
    % image encryption
    EI=encrpyt_in_block_level(JI,encryption_key,u,v,msb);
    % generate location map and contract histogram
    [H,CEI]=contract_hist(EI,u,v);
    
    len(i,j)=length(H);
    
end
    
end

ratio_dst_path=['parameter\len_block.mat'];
save(ratio_dst_path,'len');
