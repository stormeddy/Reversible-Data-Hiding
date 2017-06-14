close all;
clearvars;

permutation_key='0ahUKEwjPxaD8krTPAhVs_4MKHUY';
encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';

img_num=1338;

u=4;
v=4;
msb=8;
abso_path='D:\Matlab\image_database\image_gray\image_gray';
% abso_path='D:\Matlab\image_database\test_grayscale_image\';
% img_arr={'baboon.tiff','barbara.pgm','boat.pgm','crowd.tiff','plane.tiff',...
%     'house.bmp','lena.tiff','peppers.tiff','lake.tiff','milkdrop.tiff','stream.tiff','tank.pgm'};
N=1338;        

highest_level=100;
M=highest_level;
ratio_at_diff_level=zeros(N,M);
result=zeros(N,1);
reversibility=zeros(N,1);
level=zeros(N,1);

for i=1:N
    path=[abso_path,num2str(i),'.tif'];
%     I=imread(path);    
%     I=imread('D:\Matlab\image_database\test_grayscale_image\lena.tiff');
%     I=imread('lena.pgm');
%     path=[abso_path,char(img_arr(i))];
    I=imread(path); 
    [m,n]=size(I);
    k=0;
    AEI=I;
    total_add_bits=[];
    to_most=false;
%     highest_level=100;
    while true
        
        k=k+1;
        % embed bits level k        
        pre_AEI=AEI;
        add_bits=randi([0 1],numel(AEI),1);
        disp(['embed at level ',num2str(k)]);
        [AEI,ratio,num]=general_embed(pre_AEI,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key);
        ratio
        ratio_at_diff_level(i,k)=ratio;
        if k==1 && ratio<0
            % cannot embed any bits
            disp('cannot embed any bits')
            break;
        end
        if k>1 && ratio<0
            to_most=true;
            disp(['can only embed up to level ',num2str(k-1)]);
            break;
        end
        result(i)=result(i)+ratio;
        total_add_bits=[total_add_bits;add_bits(1:num)];
        if k==highest_level
            break
        end
    end
    if k==1
        % cannot embed any bits, cannot extract
        continue        
    end
    if to_most==true
        RI=pre_AEI;
    else
        RI=AEI;
        k=k+1;
    end
    level(i)=k-1;
    total_extracted_bits=[];
    while k>1        
        k=k-1;
        disp(['extract at level ',num2str(k)]);
        [RI,extracted_bits]=general_extract(RI,u,v,msb,permutation_key,encryption_key,data_hiding_key);
        total_extracted_bits=[extracted_bits;total_extracted_bits];
    end
    if isequal(RI,I) && isequal(total_extracted_bits,total_add_bits)        
        reversibility(i)=1;
    end
    disp(['finish embed image',num2str(i)]);
    disp(['embedding capacity:',num2str(result(i))]);
end

% save('ratio_ucid_multi_levels.mat','result');
% save('reversibility_ucid_multi_levels.mat','reversibility');
% save('level_ucid_multi_levels.mat','level');