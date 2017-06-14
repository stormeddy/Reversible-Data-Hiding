close all;
clearvars;
cd('D:\Matlab\work\reversible\Reversible Image Watermarking Using Interpolation Technique')
[reversibility_ucid2,num_ucid2,ratio_ucid2,psnr_ucid2,all_ratio_ucid2,all_psnr_ucid2]=RIWUIT_ucid;
% cd('D:\Matlab\work\reversible\ghl_color')
cd('D:\Matlab\work\reversible\ghl_color2')
[reversibility_ucid1,num_ucid1,ratio_ucid1,psnr_ucid1,all_ratio_ucid1,all_psnr_ucid1]=GHL_COLOR_ucid;


reversibility_ucid=[reversibility_ucid1,reversibility_ucid2];
num_ucid=[num_ucid1,num_ucid2];
ratio_ucid=[ratio_ucid1,ratio_ucid2];
psnr_ucid=[psnr_ucid1,psnr_ucid2];
all_ratio_ucid=[all_ratio_ucid1,all_ratio_ucid2];
all_psnr_ucid=[all_psnr_ucid1,all_psnr_ucid2];

% save_path='data\';
% save([save_path 'reversibility_ucid.mat'],'reversibility_ucid');
% save([save_path 'num_ucid.mat'],'num_ucid');
% save([save_path 'ratio_ucid.mat'],'ratio_ucid');
% save([save_path 'psnr_ucid.mat'],'psnr_ucid');
% save([save_path 'all_ratio_ucid.mat'],'all_ratio_ucid');
% save([save_path 'all_psnr_ucid.mat'],'all_psnr_ucid');
% 
% 
% all_ratio_ucid_high_ind=find(all_ratio_ucid(:,1)>=all_ratio_ucid(:,2));
% ratio_ucid_high_ind_1=find(ratio_ucid1(:,1)>=ratio_ucid2(:,1));
% ratio_ucid_high_ind_2=find(ratio_ucid1(:,2)>=ratio_ucid2(:,2));
% ratio_ucid_high_ind_3=find(ratio_ucid1(:,3)>=ratio_ucid2(:,3));
% ratio_ucid_high_ind_union=union(union(ratio_ucid_high_ind_1,ratio_ucid_high_ind_2),ratio_ucid_high_ind_3);
% ratio_ucid_high_ind_complementary=setdiff([1:1338]',ratio_ucid_high_ind_union);

% cannot_embed_ind=union(union(find(ratio_ucid2(:,1)==0),find(ratio_ucid2(:,2)==0)),find(ratio_ucid2(:,3)==0));
% ratio_cannot_embed=ratio_ucid(cannot_embed_ind,:);