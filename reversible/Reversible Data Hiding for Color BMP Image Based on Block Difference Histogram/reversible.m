close all;
clearvars;
path='4.2.0';
Num=7;
ratio_std=zeros(Num,3);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
psnr_std=zeros(Num,3);
all_psnr_std=zeros(Num,1);
reversibility_std=zeros(Num,3);

for i=1:1
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    AI_all=I;
    for j=1:3
       Ch=I(:,:,j);
       add_bits=randi([0 1],numel(Ch),1);
       u=3;
       v=3;
       [AI,num,ratio_std(i,j),base_pixels,a,b]=general_embed(Ch,add_bits,u,v);
       psnr_std(i,j)=psnr(uint8(AI),uint8(Ch));
       AI_all(:,:,j)=AI;
       if ratio_std(i,j)<0
           continue;
       end
       [RI,extract_bits]=general_extract(AI,u,v,base_pixels,a);
       reversibility_std(i,j)=isequal(RI,Ch)&isequal(extract_bits,add_bits(1:num));
       
       
    end
    all_psnr_std(i)=psnr(uint8(AI_all),I);
    
end
all_ratio_std=sum(ratio_std,2);

save_path='data\';
% save([save_path 'ratio_std.mat'],'ratio_std');
% save([save_path 'psnr_std.mat'],'psnr_std');
% save([save_path 'all_psnr_std.mat'],'all_psnr_std');
% save([save_path 'reversibility_std.mat'],'reversibility_std');
% save([save_path 'all_ratio_std.mat'],'all_ratio_std');