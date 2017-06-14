close all;
clearvars;
path='4.2.0';
Num=7;
ratio_std1=zeros(Num,3);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
psnr_std1=zeros(Num,3);
all_psnr_std1=zeros(Num,1);
reversibility_std=zeros(Num,3);

ratio_std2=zeros(Num,3);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
psnr_std2=zeros(Num,3);
all_psnr_std2=zeros(Num,1);
reversibility_std=zeros(Num,3);

for i=3:6
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    AI1_all=I;
    AI2_all=I;
    for j=1:3
       Ch=I(:,:,j);
       add_bits=randi([0 1],numel(Ch),1);
       u=3;
       v=3;
       [AI1,num,ratio_std1(i,j),base_pixels,a,b]=general_embed(Ch,add_bits,u,v);
       psnr_std1(i,j)=psnr(uint8(AI1),uint8(Ch));
       AI1_all(:,:,j)=AI1;
       
       add_bits=randi([0 1],floor(num/6),1);
       [AI2,num,ratio_std2(i,j),base_pixels,a,b]=general_embed(AI1,add_bits,u,v);
       psnr_std2(i,j)=psnr(uint8(AI2),uint8(Ch));
       AI2_all(:,:,j)=AI2;
%        if ratio_std(i,j)<0
%            continue;
%        end
%        [RI,extract_bits]=general_extract(AI,u,v,base_pixels,a);
%        reversibility_std(i,j)=isequal(RI,Ch)&isequal(extract_bits,add_bits(1:num));
       
       
    end
    all_psnr_std1(i)=psnr(uint8(AI1_all),I);
    all_psnr_std2(i)=psnr(uint8(AI2_all),I);
end
all_ratio_std1=sum(ratio_std1,2);
all_ratio_std2=sum(ratio_std2,2);

ratio_std=ratio_std1+ratio_std2;

save_path='data\';
% save([save_path 'ratio_std.mat'],'ratio_std');
% save([save_path 'psnr_std.mat'],'psnr_std');
% save([save_path 'all_psnr_std.mat'],'all_psnr_std');
% save([save_path 'reversibility_std.mat'],'reversibility_std');
% save([save_path 'all_ratio_std.mat'],'all_ratio_std');