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
%     I=imread('lena.pgm');
    [m,n]=size(I);
    k=0;
    AEI=I;
    total_add_bits=[];
    while true        
        k=k+1;
        % embed bits level k        
        pre_AEI=AEI;
        add_bits=randi([0 1],numel(AEI),1);
        disp(['embed at level ',num2str(k)]);
        [AEI,ratio,num1]=general_embed(pre_AEI,u,v,jump,msb,add_bits,encryption_key,data_hiding_key);
        if k==1 && ratio<0
            % cannot embed any bits
            disp('cannot embed any bits')
            break;
        end
        if k>1 && ratio<0
            disp(['can only embed up to level ',num2str(k-1)]);
            break;
        end
        result(i)=result(i)+ratio;
        total_add_bits=[total_add_bits;add_bits(1:num1)];
    end
    if k==1
        continue        
    end
    RI=pre_AEI;
    total_extracted_bits=[];
    while k>1        
        k=k-1;
        disp(['extract at level ',num2str(k)]);
        [RI,extracted_bits]=general_extract(RI,u,v,jump,msb,encryption_key,data_hiding_key);
        total_extracted_bits=[extracted_bits;total_extracted_bits];
    end
    if isequal(RI,I) && isequal(total_extracted_bits,total_add_bits)        
        reversibility(i)=1;
    end
    disp(['finish embed image',num2str(i)]);
end

% save('ratio_multi_levels.mat','result');
% save('reversibility_multi_levels.mat','reversibility');