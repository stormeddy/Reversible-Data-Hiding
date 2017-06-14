close all;
clearvars;

msb=8;
permutation_key='0ahUKEwjPxaD8krTPAhVs_4MKHUY';
encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';
    
abso_path='D:\Matlab\image_database\test_grayscale_image\';
img_arr={'baboon.tiff','barbara.pgm','boat.pgm','crowd.tiff','plane.tiff',...
    'house.bmp','lena.tiff','peppers.tiff','lake.tiff','milkdrop.tiff','stream.tiff','tank.pgm'};
N=numel(img_arr);

u=4;
v=4;

M=32;

ratio_at_diff_level=zeros(N,M);
result=zeros(N,1);
reversibility=zeros(N,1);

for i=1:N
    % I=imread('lena.pgm');
    i
    path=[abso_path,char(img_arr(i))];
    I=imread(path); 

    [m,n]=size(I);
    k=0;
    AEI=I;
    total_add_bits=[];
    to_most=false;
    highest_level=31;
    while true
        
        k=k+1;
        % embed bits level k        
        pre_AEI=AEI;
        add_bits=randi([0 1],numel(AEI),1);
        disp(['embed at level ',num2str(k)]);
        [AEI,ratio,num]=general_embed(pre_AEI,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key);
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
    
end
    

ratio_at_diff_level_dst_path=['parameter\diff_level_ratio.mat'];
total_ratio_dst_path=['parameter\total_ratio.mat'];
total_reversibility_dst_path=['parameter\total_reversibility.mat'];

% save(ratio_at_diff_level_dst_path,'ratio_at_diff_level');
% save(total_ratio_dst_path,'result');
% save(total_reversibility_dst_path,'reversibility');