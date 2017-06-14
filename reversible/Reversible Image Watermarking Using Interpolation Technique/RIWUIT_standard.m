% function [reversibility,num_std,ratio_std,psnr_std,all_ratio_std,all_psnr_std]=RIWUIT_standard

close all;
clearvars;
path='4.2.0';

N=7;
img_equal_std=zeros(N,3);
bit_equal_std=zeros(N,3);
% reversibility=zeros(7,3);
num_std=zeros(N,3);
ratio_std=zeros(N,3);
psnr_std=zeros(N,3);

% all_ratio_std=zeros(N,1);
all_psnr_std=zeros(N,1);

for i=7:7
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    i
    ALL_RI=zeros(size(I));
    for j=1:3
        j
        Ch3=I(:,:,j);
        add_bits=randi([0 1],numel(Ch3),1);       
        
        [AI,num,ratio,interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,add_bits);
        [RI,extract_bits]=general_extract(AI,interp_l,interp_r,ref_l,ref_r);
        
        ALL_RI(:,:,j)=AI;
        
        img_equal_std(i,j)=isequal(RI,Ch3);
        bit_equal_std(i,j)=isequal(extract_bits,add_bits(1:num));
        
        
        num_std(i,j)=num;
        ratio_std(i,j)=ratio;
        psnr_std(i,j)=psnr(uint8(AI),Ch3);
        
    end
    all_psnr_std(i)=psnr(uint8(ALL_RI),I);
end

reversibility=bitand(img_equal_std,bit_equal_std);
all_ratio_std=sum(ratio_std,2);

save_path='data\';
% end
% save([save_path 'img_equal_std.mat'],'img_equal_std');
% save([save_path 'bit_equal_std.mat'],'bit_equal_std');
% save([save_path 'reversibility.mat'],'reversibility');
% save([save_path 'num_std.mat'],'num_std');
% save([save_path 'ratio_std.mat'],'ratio_std');
% save([save_path 'psnr_std.mat'],'psnr_std');
% save([save_path 'all_ratio_std.mat'],'all_ratio_std');
% save([save_path 'all_psnr_std.mat'],'all_psnr_std');