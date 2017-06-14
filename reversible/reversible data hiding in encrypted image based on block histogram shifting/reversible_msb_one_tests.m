close all;
clearvars;

encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';


u=4;
v=4;
jump=3;
msb=1;

img_num=1338;
abso_path='D:\Matlab\image_database\image_gray\image_gray';

result=zeros(img_num,1);
reversibility=zeros(img_num,1);

for i=1:img_num
    path=[abso_path,num2str(i),'.tif'];
    I=imread(path);
    
    
    [m,n]=size(I);
    
    % image scramble and encryption
    [EI,JI]=josephus_and_encrypt(I,encryption_key,jump,u,v,msb);
    
    % generate location map and contract histogram
    [H,CEI]=contract_hist(EI,u,v);
    
    % data embedding
    data_hiding_key='howing-incorrect-resu';
    lenH=length(H);
    add_bits=[H;randi([0 1],numel(I),1)];
    [AEI,ind]=data_embedding(CEI,data_hiding_key,u,v,add_bits);
    ratio=(ind-lenH)/numel(I);
    result(i)=ratio;
    if ratio<0
        continue;
    end
    
    % data extraction
    [REI,extracted_bits]=data_extraction(AEI,data_hiding_key,u,v);
    
    
    
    % expand histogram and extract location map
    [REI,extracted_H]=expand_hist(REI,u,v,extracted_bits);
    isequal(extracted_H,H)
    isequal(REI,EI)
    
    % decryption and reverse scramble
    [RI,RJI]=reverse_josephus_and_decrypt(REI,encryption_key,jump,u,v,msb);
%     isequal(RJI,JI)
    if isequal(RI,I) && isequal(extracted_bits,add_bits(1:ind))
       reversibility(i)=1; 
    end
    
    disp(['finish embed image',num2str(i)]);
end

save('ratio_msb_one_dup.mat','result');
save('reversibility_msb_one_dup.mat','reversibility');



