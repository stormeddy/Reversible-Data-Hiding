close all;
clearvars;
path='4.2.0';

ratio_std_all=zeros(7,1);
psnr_std=zeros(7,3);
for i=4:4
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    
    Ch1=R;
    Ch2=B;
    Ch3=G;
    N=4;
    add_bits=randi([0 1],numel(Ch3),1);
    
    [AI,num,ratio,interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,Ch1,Ch2,N,add_bits);
%     [RI,extract_bits]=general_extract(AI,interp_l,interp_r,ref_l,ref_r,Ch1,Ch2,N);
    

    
%     isequal(RI,Ch3)
%     isequal(extract_bits,add_bits(1:num))
%     
% 
%     num
    ratio_std_all(i)=ratio;
    psnr_std(i,2)=psnr(uint8(AI),Ch3);
end


% save_path='data/';
% save([save_path,'ratio_std_all'],'ratio_std_all');
% save([save_path,'psnr_std'],'psnr_std');