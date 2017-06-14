close all;
clearvars;

encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';

img_num=1338;
jump=73;
u=4;
v=4;
msb=8;
abso_path='D:\Matlab\image_database\image_gray\image_gray';

result=zeros(img_num,1);
reversibility=zeros(img_num,1);

for i=1:img_num
    path=[abso_path,num2str(i),'.tif'];
    I=imread(path);    
    [m,n]=size(I);
    
    % embed bits level 1
    add_bits1=randi([0 1],numel(I),1);
    [AEI1,ratio1,num1]=general_embed(I,u,v,jump,msb,add_bits1,encryption_key,data_hiding_key);
    if ratio1<0
        % cannot embedd any bits
        continue;
    end
    
    % embed bits level 2
    add_bits2=randi([0 1],numel(I),1);
    [AEI2,ratio2,num2]=general_embed(AEI1,u,v,jump,msb,add_bits2,encryption_key,data_hiding_key);
    if ratio2<0
        % can only embed up to level 1
        disp('can only embed up to level 1');
        result(i)=ratio1;
        [RI1,extracted_bits1]=general_extract(AEI1,u,v,jump,msb,encryption_key,data_hiding_key);
        if isequal(RI1,I) && isequal(extracted_bits1,add_bits1(1:num1))
            result(i)=ratio1;
            reversibility(i)=1;
        end
        continue;
    end
    
    % extract bits level 2
    [RI2,extracted_bits2]=general_extract(AEI2,u,v,jump,msb,encryption_key,data_hiding_key);
    % extract bits level 1
    [RI1,extracted_bits1]=general_extract(RI2,u,v,jump,msb,encryption_key,data_hiding_key);
    

    if isequal(RI1,I) && isequal([extracted_bits1;extracted_bits2],[add_bits1(1:num1);add_bits2(1:num2)])
        result(i)=ratio1+ratio2;
        reversibility(i)=1;
    end
    disp(['finish embed image',num2str(i)]);
end

save('ratio_level_2.mat','result');
save('reversibility_level_2.mat','reversibility');