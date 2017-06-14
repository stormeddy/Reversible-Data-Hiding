cd('D:\Matlab\work\reversible\Reversible Image Watermarking Using Interpolation Technique')
[reversibility2,num_std2,ratio_std2,psnr_std2,all_ratio_std2,all_psnr_std2]=RIWUIT_standard;
cd('D:\Matlab\work\reversible\ghl_color')
[reversibility1,num_std1,ratio_std1,psnr_std1,all_ratio_std1,all_psnr_std1]=GHL_COLOR_standard;


reversibility=[reversibility1,reversibility2];
num_std=[num_std1,num_std2];
ratio_std=[ratio_std1,ratio_std2];
psnr_std=[psnr_std1,psnr_std2];
all_ratio_std=[all_ratio_std1,all_ratio_std2];
all_psnr_std=[all_psnr_std1,all_psnr_std2];

save_path='data\';
% save([save_path 'img_equal_std.mat'],'img_equal_std');
% save([save_path 'bit_equal_std.mat'],'bit_equal_std');
% save([save_path 'reversibility.mat'],'reversibility');
% save([save_path 'num_std.mat'],'num_std');
% save([save_path 'ratio_std.mat'],'ratio_std');
% save([save_path 'psnr_std.mat'],'psnr_std');
% save([save_path 'all_ratio_std.mat'],'all_ratio_std');
% save([save_path 'all_psnr_std.mat'],'all_psnr_std');