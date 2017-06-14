close all;
clearvars;
path='4.2.0';

ratio_std=zeros(7,4);
psnr_std=zeros(7,3);
for i=1:7
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    
    I_arr=divide_image(I);
    AI_arr=cell(size(I_arr));
    for j=1:numel(I_arr)
        I_sub=I_arr{j};
        R=I_sub(:,:,1);
        G=I_sub(:,:,2);
        B=I_sub(:,:,3);

        Ch1=R;
        Ch2=B;
        Ch3=G;
        N=4;
        add_bits=randi([0 1],numel(Ch3),1);

        [AI_arr{j},num,ratio_std(i,j),interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,Ch1,Ch2,N,add_bits);
%     [RI,extract_bits]=general_extract(AI,interp_l,interp_r,ref_l,ref_r,Ch1,Ch2,N);
    
    end
    AI=merge_image(AI_arr);
%     isequal(RI,Ch3)
%     isequal(extract_bits,add_bits(1:num))
%     
% 
%     num
    
    psnr_std(i,2)=psnr(uint8(AI),I(:,:,2));
    
%     figure(1)
%     imshow(I(:,:,2));
%     figure(2)
%     imshow(uint8(AI));
    
end
ratio_std=ratio_std/4;
ratio_std_all=sum(ratio_std,2);

save_path='data/';
save([save_path,'ratio_std_all'],'ratio_std_all');
save([save_path,'ratio_std'],'ratio_std');
save([save_path,'psnr_std'],'psnr_std');