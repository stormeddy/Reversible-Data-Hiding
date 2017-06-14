close all;
clearvars;
path='D:\Matlab\image_database\ucid\ucid';

Num=1338;
img_equal_final_ucid=zeros(Num,3);
bit_equal_final_ucid=zeros(Num,3);

num_final_ucid=zeros(Num,3);
ratio_final_ucid=zeros(Num,3);
psnr_final_ucid=zeros(Num,3);

all_psnr_final_ucid=zeros(Num,1);
flag_ucid=-ones(Num,1);

riwuit_non_sample_peak_count_ucid=zeros(Num,3);
ghl_non_sample_peak_count_ucid=zeros(Num,3);

for i=1:Num
    img=[path,num2str(i,'%05d'),'.tif'];
    I=imread(img);
    i
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    C={R G B};
    
    % test which channel improves ratio most or none of them improve ratio
    cd('D:\Matlab\work\reversible\Reversible Image Watermarking Using Interpolation Technique')
    riwuit_ratio=zeros(1,3);
    for j=1:3
        Ch3=I(:,:,j);
        
        % record corresponding peak count of non_sample interpolation
        riwuit_non_sample_peak_count_ucid(i,j)=cal_peak_count(Ch3);
        
        add_bits=randi([0 1],numel(Ch3),1);
        [~,~,riwuit_ratio(j),~,~,~,~]=general_embed(Ch3,add_bits);
    end
    
    cd('D:\Matlab\work\reversible\ghl_color_final')
    ghl_final_ratio=zeros(1,3);
    
    order=[3 2 1;
           1 3 2;
           2 1 3];
    N=3.6;
    for j=1:3
        ch1=order(j,1);
        ch2=order(j,2);
        ch3=order(j,3);
        
        Ch1=C{ch1};
        Ch2=C{ch2};
        Ch3=C{ch3};
        
        % record corresponding peak count of non_sample interpolation
        ghl_non_sample_peak_count_ucid(i,j)=cal_peak_count(Ch3,Ch1,Ch2,N);
        
        
        % embed in Ch3 channel
        add_bits=randi([0 1],numel(Ch3),1);
        [~,~,ghl_final_ratio(j),~,~,~,~]=general_embed(Ch3,Ch1,Ch2,N,add_bits);        
    end
    
    diff=ghl_final_ratio-riwuit_ratio;
    [max_diff,channel_ind]=max(diff,[],2);
    if(max_diff<=0)
       flag=0;
    else
       flag=channel_ind;
    end
    flag_ucid(i)=flag;
    
    % formal embedding   
    
    if flag~=0
        % one channel is applied with inter_channel embedding
        % the other two channels are applied with inner_channel embedding
        ch1=order(flag,1);
        ch2=order(flag,2);
        ch3=order(flag,3);
        
        Ch1=C{ch1};
        Ch2=C{ch2};
        Ch3=C{ch3};
        
        % embedding phase
        AI=zeros(size(I));
        add_bits=randi([0 1],numel(Ch3),3);
        
        interp_l=zeros(1,3);
        interp_r=zeros(1,3);
        ref_l=zeros(1,3);
        ref_r=zeros(1,3);
        % first inter_channel embedding
        [AI(:,:,ch3),num_final_ucid(i,ch3),ratio_final_ucid(i,ch3),interp_l(ch3),interp_r(ch3),ref_l(ch3),ref_r(ch3)]=general_embed(Ch3,Ch1,Ch2,N,add_bits(:,ch3));
        
        % then inner_channel embedding
        cd('D:\Matlab\work\reversible\Reversible Image Watermarking Using Interpolation Technique')
        [AI(:,:,ch1),num_final_ucid(i,ch1),ratio_final_ucid(i,ch1),interp_l(ch1),interp_r(ch1),ref_l(ch1),ref_r(ch1)]=general_embed(Ch1,add_bits(:,ch1));
        [AI(:,:,ch2),num_final_ucid(i,ch2),ratio_final_ucid(i,ch2),interp_l(ch2),interp_r(ch2),ref_l(ch2),ref_r(ch2)]=general_embed(Ch2,add_bits(:,ch2));
        
        ch=[ch1;ch2;ch3];
        for j=1:3
           psnr_final_ucid(i,ch(j))=psnr(uint8(AI(:,:,ch(j))),I(:,:,ch(j)));
        end        
        all_psnr_final_ucid(i)=psnr(uint8(AI),I);
        
        if ratio_final_ucid(i,ch3)<0 || ratio_final_ucid(i,ch1)<0 || ratio_final_ucid(i,ch2)<0
           continue; 
        end
        
        % extraction phase
        RI=zeros(size(I));
        extract_bits=zeros(numel(Ch3),3);
        num_extract=zeros(Num,3);
        
        % first inner_channel extraction
        [RI(:,:,ch1),extract_bits1]=general_extract(AI(:,:,ch1),interp_l(ch1),interp_r(ch1),ref_l(ch1),ref_r(ch1));
        num_extract(i,ch1)=numel(extract_bits1);
        extract_bits(1:num_extract(i,ch1),ch1)=extract_bits1;
        
        [RI(:,:,ch2),extract_bits2]=general_extract(AI(:,:,ch2),interp_l(ch2),interp_r(ch2),ref_l(ch2),ref_r(ch2));
        num_extract(i,ch2)=numel(extract_bits2);
        extract_bits(1:num_extract(i,ch2),ch2)=extract_bits2;
        
        % then inter_channel extraction
        cd('D:\Matlab\work\reversible\ghl_color_final')
        [RI(:,:,ch3),extract_bits3]=general_extract(AI(:,:,ch3),interp_l(ch3),interp_r(ch3),ref_l(ch3),ref_r(ch3),RI(:,:,ch1),RI(:,:,ch2),N);
        num_extract(i,ch3)=numel(extract_bits3);
        extract_bits(1:num_extract(i,ch3),ch3)=extract_bits3;
        
        
        
        for j=1:3
            img_equal_final_ucid(i,ch(j))=isequal(RI(:,:,ch(j)),I(:,:,ch(j)));
            bit_equal_final_ucid(i,ch(j))=isequal(add_bits(1:num_extract(i,ch(j)),ch(j)),extract_bits(1:num_extract(i,ch(j)),ch(j)));
%             psnr_final_ucid(i,ch(j))=psnr(uint8(AI(:,:,ch(j))),I(:,:,ch(j)));
        end
        
%         all_psnr_final_ucid(i)=psnr(uint8(AI),I);
        
    else 
        
        % all the channels are applied with inner_channel embedding
        cd('D:\Matlab\work\reversible\Reversible Image Watermarking Using Interpolation Technique')
        AI=zeros(size(I));
        for j=1:3
            
            j
            Ch3=I(:,:,j);
            add_bits=randi([0 1],numel(Ch3),1);
            
            [AI(:,:,j),num_final_ucid(i,j),ratio_final_ucid(i,j),interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,add_bits);
            psnr_final_ucid(i,j)=psnr(uint8(AI(:,:,j)),Ch3);
            
            if ratio_final_ucid(i,j)<0
                continue;
            end
            
            [RI,extract_bits]=general_extract(AI(:,:,j),interp_l,interp_r,ref_l,ref_r);
            
            
            img_equal_final_ucid(i,j)=isequal(RI,Ch3);
            bit_equal_final_ucid(i,j)=isequal(extract_bits,add_bits(1:num_final_ucid(i,j)));
            
            
        end
        all_psnr_final_ucid(i)=psnr(uint8(AI),I);
    end
    cd('D:\Matlab\work\reversible\ghl_color_final')
end

diff_non_sample_peak_count_ucid=ghl_non_sample_peak_count_ucid-riwuit_non_sample_peak_count_ucid;
[max_diff_non_sample_peak_count_ucid,flag_peak_count_ucid]=max(diff_non_sample_peak_count_ucid,[],2);
flag_peak_count_ucid(max_diff_non_sample_peak_count_ucid<=0)=0;

all_ratio_final_ucid=sum(ratio_final_ucid,2);
reversibility_final_ucid=bitand(img_equal_final_ucid,bit_equal_final_ucid);

save_path='which_channel_peak_count_ucid\';
% save([save_path 'img_equal_final_ucid.mat'],'img_equal_final_ucid');
% save([save_path 'bit_equal_final_ucid.mat'],'bit_equal_final_ucid');
% save([save_path 'reversibility_final_ucid.mat'],'reversibility_final_ucid');
% save([save_path 'num_final_ucid.mat'],'num_final_ucid');
% save([save_path 'ratio_final_ucid.mat'],'ratio_final_ucid');
% save([save_path 'psnr_final_ucid.mat'],'psnr_final_ucid');
% save([save_path 'all_ratio_final_ucid.mat'],'all_ratio_final_ucid');
% save([save_path 'all_psnr_final_ucid.mat'],'all_psnr_final_ucid');
% save([save_path 'flag_ucid.mat'],'flag_ucid');
% 
% save([save_path 'riwuit_non_sample_peak_count_ucid.mat'],'riwuit_non_sample_peak_count_ucid');
% save([save_path 'ghl_non_sample_peak_count_ucid.mat'],'ghl_non_sample_peak_count_ucid');
% save([save_path 'flag_peak_count_ucid.mat'],'flag_peak_count_ucid');