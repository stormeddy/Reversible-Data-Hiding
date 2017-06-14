close all;
clearvars;


abso_path='D:\Matlab\image_database\test_grayscale_image\';
img_arr={'baboon.tiff','barbara.tiff','boats.tiff','crowd.tiff','plane.tiff',...
    'house.bmp','lena.tiff','peppers.tiff','lake.tiff','milkdrop.tiff','stream.tiff','tank.pgm'};
N=numel(img_arr);
u=4;
v=4;

result=zeros(N,1);
reversibility=zeros(N,1);

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
        reversibility(i)=1;
        result(i)=ratio;
    end
    
    
    
end

ratio_dst_path=['parameter\ratio_rule.mat'];
rev_dst_path=['parameter\rev_rule.mat'];
save(ratio_dst_path,'result');
save(rev_dst_path,'reversibility');