close all;
clearvars;


abso_path='D:\Matlab\image_database\test_grayscale_image\';
img_arr={'baboon.tiff','barbara.pgm','boat.pgm','crowd.tiff','plane.tiff',...
    'house.bmp','lena.tiff','peppers.tiff','lake.tiff','milkdrop.tiff','stream.tiff','tank.pgm'};
N=numel(img_arr);

u_arr=[2,3,4,5,6,7,8];
v_arr=[2,3,4,5,6,7,8];
M=numel(u_arr);

result=zeros(N,M);
reversibility=zeros(N,M);
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
    [AEI,ratio,num]=general_embed(I,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key);
    
    % extract bits
    [RI,extracted_bits]=general_extract(AEI,u,v,msb,permutation_key,encryption_key,data_hiding_key);
    if isequal(RI,I) && isequal(extracted_bits,add_bits(1:num))    
        reversibility(i,j)=1;
        result(i,j)=ratio;
    end
    
end
    
end

ratio_dst_path=['parameter\ratio_block.mat'];
rev_dst_path=['parameter\rev_block.mat'];
save(ratio_dst_path,'result');
save(rev_dst_path,'reversibility');