% function [reversibility_ucid,num_ucid,ratio_ucid,psnr_ucid]=single_channel_ucid_ghl_color

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




for i=1212
    img=[path,num2str(i,'%05d'),'.tif'];
    I=imread(img);
    i
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    C={R G B};
    
    order=[3 2 1;
           1 3 2;
           2 1 3];
    N=3.6;
    for j=1:1
        ch1=order(j,1);
        ch2=order(j,2);
        ch3=order(j,3);
        
        Ch1=C{ch1};
        Ch2=C{ch2};
        Ch3=C{ch3};
        
        
        
        % embed in Ch3 channel
        add_bits3=randi([0 1],numel(Ch3),1);
        [ACh3,num3,ratio,interp_l3,interp_r3,ref_l3,ref_r3]=general_embed(Ch3,Ch1,Ch2,N,add_bits3);
       
        num_ucid(i,ch3)=num3;
        ratio_ucid(i,ch3)=ratio;
        psnr_ucid(i,ch3)=psnr(uint8(ACh3),Ch3);
        
        if ratio<0
            continue;
        end
        
        % extract in Ch3 channel
        [RI3,extract_bits]=general_extract(ACh3,interp_l3,interp_r3,ref_l3,ref_r3,Ch1,Ch2,N);
        img_equal_ucid(i,ch3)=isequal(uint8(RI3),Ch3);
        bit_equal_ucid(i,ch3)=isequal(extract_bits,add_bits3(1:num3));
        
        img_equal_ucid(i,ch3)
        bit_equal_ucid(i,ch3)
        
    end
    
  
end

reversibility_ucid=bitand(img_equal_ucid,bit_equal_ucid);

% save_path='data\';
% save([save_path 'single_img_equal_ucid.mat'],'img_equal_ucid');
% save([save_path 'single_bit_equal_ucid.mat'],'bit_equal_ucid');
% save([save_path 'single_reversibility_ucid.mat'],'reversibility_ucid');
% save([save_path 'single_num_ucid.mat'],'num_ucid');
% save([save_path 'single_ratio_ucid.mat'],'ratio_ucid');
% save([save_path 'single_psnr_ucid.mat'],'psnr_ucid');

% zero_row=[0 0 0];
% zero_ind=find(ismember(reversibility_ucid,zero_row,'rows'));
% cannot_embed_ind1=find(ratio_ucid(:,1)<=0);
% cannot_embed_ind2=find(ratio_ucid(:,2)<=0);
% cannot_embed_ind3=find(ratio_ucid(:,3)<=0);
% cannot_embed_ind_all=intersect(intersect(cannot_embed_ind1,cannot_embed_ind2),cannot_embed_ind3);


%  wrong_ind1=find(reversibility_ucid(:,1)==0);
%  wrong_ind2=find(reversibility_ucid(:,2)==0);
%  wrong_ind3=find(reversibility_ucid(:,3)==0);
%  wrong_ind_all=union(union(wrong_ind1,wrong_ind2),wrong_ind3);

% end