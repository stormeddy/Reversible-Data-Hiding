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

M=32;
ratio_at_diff_level=zeros(img_num,M);
result=zeros(img_num,1);
reversibility=zeros(img_num,1);
level=zeros(img_num,1);

for i=1:img_num
    path=[abso_path,num2str(i),'.tif'];
    I=imread(path);    
%     I=imread('lena.pgm');
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

save('ucid_diff_level_ratio.mat','ratio_at_diff_level')

N=img_num;
a=zeros(N,1);
b=zeros(N,1);
for i=1:img_num
    h=figure(i);
    level=1;
    while(ratio_at_diff_level(i,level)>0)
        level=level+1;
    end
    x=1:level-1;
    y=ratio_at_diff_level(i,1:level-1);
    ft=fit(x',y','exp1');
    a(i)=round(ft.a*10000)/10000;
    b(i)=round(ft.b*10000)/10000;
end
