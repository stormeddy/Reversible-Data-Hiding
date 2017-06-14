close all;
clearvars;
path='4.2.0';
num_std=zeros(7,3);
ratio_std=zeros(7,3);
psnr_std=zeros(7,3);
for i=3:6
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    Nm=[3 2 1;1 3 2;2 1 3];
    for k=1:3
        
        N=Nm(k,:);
        Ch1=I(:,:,N(1));
        Ch2=I(:,:,N(2));
        Ch3=I(:,:,N(3));

             M=[	
         0.4124564  0.3575761  0.1804375
         0.2126729  0.7151522  0.0721750    
         0.0193339  0.1191920  0.9503041];
        temp_M=M;
        % N用于确定通道间插值方式 N=[1 2 3]表示顺序为R G B
        for j=1:3
            M(:,j)=temp_M(:,N(j));
        end

        add_bits=randi([0 1],numel(Ch3),1);

        [AI,num,ratio,interp_l,interp_r,ref_l,ref_r]=general_embed(Ch3,Ch1,Ch2,M,add_bits,N);
    %     [RI,extract_bits]=general_extract(AI,interp_l,interp_r,ref_l,ref_r,Ch1,Ch2,M,N);


        num_std(i,k)=num;
        ratio_std(i,k)=ratio;
        psnr_std(i,k)=psnr(uint8(AI),Ch3);
    end    
end
save_path='data\';
% save([save_path 'num_std.mat'],'num_std');
% save([save_path 'ratio_std.mat'],'ratio_std');
% save([save_path 'psnr_std.mat'],'psnr_std');