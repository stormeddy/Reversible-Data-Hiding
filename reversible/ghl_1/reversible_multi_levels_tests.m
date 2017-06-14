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