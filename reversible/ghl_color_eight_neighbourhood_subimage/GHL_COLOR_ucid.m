function [reversibility_ucid,num_ucid,ratio_ucid,psnr_ucid,all_ratio_ucid,all_psnr_ucid]=GHL_COLOR_ucid

close all;
clearvars;
path='D:\Matlab\image_database\ucid\ucid';

Num=1338;
img_equal_ucid=zeros(Num,3);
bit_equal_ucid=zeros(Num,3);
% reversibility=zeros(7,3);
num_ucid=zeros(Num,3);
ratio_ucid=zeros(Num,3);
psnr_ucid=zeros(Num,3);

% all_ratio_ucid=zeros(N,1);
all_psnr_ucid=zeros(Num,1);

for i=1:Num
    img=[path,num2str(i,'%05d'),'.tif'];
    I=imread(img);
    i
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    C={R G B};
    ch1=3;ch2=1;ch3=2;
    Ch1=C{ch1};
    Ch2=C{ch2};
    Ch3=C{ch3};
    
    N=3.6;
    ALL_RI=zeros(size(I));
        % embed in Ch3 channel
        add_bits3=randi([0 1],numel(Ch3),1);       
        [ACh3,num3,ratio,interp_l3,interp_r3,ref_l3,ref_r3]=general_embed(Ch3,Ch1,Ch2,N,add_bits3);
        ALL_RI(:,:,ch3)=ACh3;     
        num_ucid(i,ch3)=num3;
        ratio_ucid(i,ch3)=ratio;
        psnr_ucid(i,ch3)=psnr(uint8(ACh3),Ch3);
        
        if ratio<0
            continue;
        end
        
        % embed in Ch2 channel
        add_bits2=randi([0 1],numel(Ch2),1);  
        [ACh2,num2,ratio,interp_l2,interp_r2,ref_l2,ref_r2]=general_embed(Ch2,Ch1,ACh3,N,add_bits2);
        ALL_RI(:,:,ch2)=ACh2;
        num_ucid(i,ch2)=num2;
        ratio_ucid(i,ch2)=ratio;
        psnr_ucid(i,ch2)=psnr(uint8(ACh2),Ch2);
        
        if ratio<0
            continue;
        end
        
        % embed in Ch1 channel
        add_bits1=randi([0 1],numel(Ch1),1);    
        [ACh1,num1,ratio,interp_l1,interp_r1,ref_l1,ref_r1]=general_embed(Ch1,ACh2,ACh3,N,add_bits1);
        ALL_RI(:,:,ch1)=ACh1;
        num_ucid(i,ch1)=num1;
        ratio_ucid(i,ch1)=ratio;
        psnr_ucid(i,ch1)=psnr(uint8(ACh1),Ch1);
        
        if ratio<0
            continue;
        end
        
        % extract in Ch1 channel
        [RI1,extract_bits]=general_extract(ACh1,interp_l1,interp_r1,ref_l1,ref_r1,ACh2,ACh3,N);
        img_equal_ucid(i,ch1)=isequal(RI1,Ch1);
        bit_equal_ucid(i,ch1)=isequal(extract_bits,add_bits1(1:num1));  
        
        % extract in Ch2 channel
        [RI2,extract_bits]=general_extract(ACh2,interp_l2,interp_r2,ref_l2,ref_r2,RI1,ACh3,N);
        img_equal_ucid(i,ch2)=isequal(RI2,Ch2);
        bit_equal_ucid(i,ch2)=isequal(extract_bits,add_bits2(1:num2));  
        
        % extract in Ch3 channel
        [RI3,extract_bits]=general_extract(ACh3,interp_l3,interp_r3,ref_l3,ref_r3,RI1,RI2,N);
        img_equal_ucid(i,ch3)=isequal(RI3,Ch3);
        bit_equal_ucid(i,ch3)=isequal(extract_bits,add_bits3(1:num3)); 
        

    all_psnr_ucid(i)=psnr(uint8(ALL_RI),I);
end

reversibility_ucid=bitand(img_equal_ucid,bit_equal_ucid);
all_ratio_ucid=sum(ratio_ucid,2);

% save_path='data\';

% figure(1)
% imshow(I)
% figure(2)
% imshow(uint8(ALL_RI))

% save([save_path 'img_equal_ucid.mat'],'img_equal_ucid');
% save([save_path 'bit_equal_ucid.mat'],'bit_equal_ucid');
% save([save_path 'reversibility_ucid.mat'],'reversibility');
% save([save_path 'num_ucid.mat'],'num_ucid');
% save([save_path 'ratio_ucid.mat'],'ratio_ucid');
% save([save_path 'psnr_ucid.mat'],'psnr_ucid');
% save([save_path 'all_ratio_ucid.mat'],'all_ratio_ucid');
% save([save_path 'all_psnr_ucid.mat'],'all_psnr_ucid');

% end