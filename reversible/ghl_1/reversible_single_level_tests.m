close all;
clearvars;

encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';

img_num=1338;
abso_path='D:\Matlab\image_database\image_gray\image_gray';

result=zeros(img_num,1);
reversibility=zeros(img_num,1);

for i=1:img_num
    path=[abso_path,num2str(i),'.tif'];
    I=imread(path);
    
    [m,n]=size(I);
    
    jump=73;
    u=4;
    v=4;
    msb=8;
    add_bits=randi([0 1],numel(I),1);
    [AEI,ratio,num]=general_embed(I,u,v,jump,msb,add_bits,encryption_key,data_hiding_key);
 
    result(i)=ratio;
    if ratio<0
        % cannot embedd any bits
        continue;
    end
    [RI,extracted_bits]=general_extract(AEI,u,v,jump,msb,encryption_key,data_hiding_key);

    if isequal(RI,I) && isequal(extracted_bits,add_bits(1:num))
       reversibility(i)=1; 
    end
    i
end

save('result2.mat','result');
