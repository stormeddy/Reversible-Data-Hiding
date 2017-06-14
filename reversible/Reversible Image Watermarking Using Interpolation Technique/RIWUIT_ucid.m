function [reversibility_ucid,num_ucid,ratio_ucid,psnr_ucid,all_ratio_ucid,all_psnr_ucid]=RIWUIT_ucid

close all;
clearvars;
path='D:\Matlab\image_database\ucid\ucid';

N=1338;
img_equal_ucid=zeros(N,3);
bit_equal_ucid=zeros(N,3);
% reversibility=zeros(7,3);
num_ucid=zeros(N,3);
ratio_ucid=zeros(N,3);
psnr_ucid=zeros(N,3);

% all_ratio_ucid=zeros(N,1);
all_psnr_ucid=zeros(N,1);

for i=1:N
    img=[path,num2str(i,'%05d'),'.tif'];
    I=imread(img);
    i
    ALL_RI=zeros(size(I));
    for j=1:3
        j
        Ch3=I(:,:,j);
        add_bits=randi([0 1],numel(Ch3),1);       
        
        [AI,num,ratio,interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,add_bits);
        
        if ratio<0
            continue;
        end
        [RI,extract_bits]=general_extract(AI,interp_l,interp_r,ref_l,ref_r);
        
        ALL_RI(:,:,j)=AI;
        
        img_equal_ucid(i,j)=isequal(RI,Ch3);
        bit_equal_ucid(i,j)=isequal(extract_bits,add_bits(1:num));
        
        
        num_ucid(i,j)=num;
        ratio_ucid(i,j)=ratio;
        psnr_ucid(i,j)=psnr(uint8(AI),Ch3);
        
    end
    all_psnr_ucid(i)=psnr(uint8(ALL_RI),I);
end

reversibility_ucid=bitand(img_equal_ucid,bit_equal_ucid);
all_ratio_ucid=sum(ratio_ucid,2);

save_path='data\';
% end
% save([save_path 'img_equal_ucid.mat'],'img_equal_ucid');
% save([save_path 'bit_equal_ucid.mat'],'bit_equal_ucid');
% save([save_path 'reversibility_ucid.mat'],'reversibility');
% save([save_path 'num_ucid.mat'],'num_ucid');
% save([save_path 'ratio_ucid.mat'],'ratio_ucid');
% save([save_path 'psnr_ucid.mat'],'psnr_ucid');
% save([save_path 'all_ratio_ucid.mat'],'all_ratio_ucid');
% save([save_path 'all_psnr_ucid.mat'],'all_psnr_ucid');