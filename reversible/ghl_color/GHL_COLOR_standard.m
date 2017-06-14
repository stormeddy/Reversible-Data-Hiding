function [reversibility,num_std,ratio_std,psnr_std,all_ratio_std,all_psnr_std]=GHL_COLOR_standard

close all;
clearvars;
path='4.2.0';

Num=7;
img_equal_std=zeros(Num,3);
bit_equal_std=zeros(Num,3);
% reversibility=zeros(7,3);
num_std=zeros(Num,3);
ratio_std=zeros(Num,3);
psnr_std=zeros(Num,3);

% all_ratio_std=zeros(N,1);
all_psnr_std=zeros(Num,1);

for i=3:7
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    i
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    C={R G B};
    ch1=1;ch2=3;ch3=2;
    Ch1=C{ch1};
    Ch2=C{ch2};
    Ch3=C{ch3};
    
    N=500;
    ALL_RI=zeros(size(I));
        % embed in Ch3 channel
        add_bits3=randi([0 1],numel(Ch3),1);       
        [ACh3,num3,ratio,interp_l3,interp_r3,ref_l3,ref_r3]=general_embed(Ch3,Ch1,Ch2,N,add_bits3);
        ALL_RI(:,:,ch3)=ACh3;     
        num_std(i,ch3)=num3;
        ratio_std(i,ch3)=ratio;
        psnr_std(i,ch3)=psnr(uint8(ACh3),Ch3);
        
        % embed in Ch2 channel
        add_bits2=randi([0 1],numel(Ch2),1);  
        [ACh2,num2,ratio,interp_l2,interp_r2,ref_l2,ref_r2]=general_embed(Ch2,Ch1,ACh3,N,add_bits2);
        ALL_RI(:,:,ch2)=ACh2;
        num_std(i,ch2)=num2;
        ratio_std(i,ch2)=ratio;
        psnr_std(i,ch2)=psnr(uint8(ACh2),Ch2);
        
        % embed in Ch1 channel
        add_bits1=randi([0 1],numel(Ch1),1);    
        [ACh1,num1,ratio,interp_l1,interp_r1,ref_l1,ref_r1]=general_embed(Ch1,ACh2,ACh3,N,add_bits1);
        ALL_RI(:,:,ch1)=ACh1;
        num_std(i,ch1)=num1;
        ratio_std(i,ch1)=ratio;
        psnr_std(i,ch1)=psnr(uint8(ACh1),Ch1);
        
        
        
        % extract in Ch1 channel
        [RI1,extract_bits]=general_extract(ACh1,interp_l1,interp_r1,ref_l1,ref_r1,ACh2,ACh3,N);
        img_equal_std(i,ch1)=isequal(RI1,Ch1);
        bit_equal_std(i,ch1)=isequal(extract_bits,add_bits1(1:num1));  
        
        % extract in Ch2 channel
        [RI2,extract_bits]=general_extract(ACh2,interp_l2,interp_r2,ref_l2,ref_r2,RI1,ACh3,N);
        img_equal_std(i,ch2)=isequal(RI2,Ch2);
        bit_equal_std(i,ch2)=isequal(extract_bits,add_bits2(1:num2));  
        
        % extract in Ch3 channel
        [RI3,extract_bits]=general_extract(ACh3,interp_l3,interp_r3,ref_l3,ref_r3,RI1,RI2,N);
        img_equal_std(i,ch3)=isequal(RI3,Ch3);
        bit_equal_std(i,ch3)=isequal(extract_bits,add_bits3(1:num3)); 
        

    all_psnr_std(i)=psnr(uint8(ALL_RI),I);
end

reversibility=bitand(img_equal_std,bit_equal_std);
all_ratio_std=sum(ratio_std,2);

save_path='data\';
% save([save_path 'img_equal_std.mat'],'img_equal_std');
% save([save_path 'bit_equal_std.mat'],'bit_equal_std');
% save([save_path 'reversibility.mat'],'reversibility');
% save([save_path 'num_std.mat'],'num_std');
% save([save_path 'ratio_std.mat'],'ratio_std');
% save([save_path 'psnr_std.mat'],'psnr_std');
% save([save_path 'all_ratio_std.mat'],'all_ratio_std');
% save([save_path 'all_psnr_std.mat'],'all_psnr_std');

% end