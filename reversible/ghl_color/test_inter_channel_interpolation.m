close all;
clearvars;
% path='4.2.0';
path='D:\Matlab\image_database\ucid\ucid';

save_path='para\';

for cnt=1:10
    test_diff_interpolation_psnr=zeros(10,3);
    img_arr=randi([1 1338],10,1);
    for i=1:10
        img=[path,num2str(img_arr(i),'%05d'),'.tif'];
        I=imread(img);
        R=I(:,:,1);
        G=I(:,:,2);
        B=I(:,:,3);
        
        
        N=50;
        
        % inter-channel interpolation
        % interpolate Ch3 according to Ch1 and Ch2
        Ch1=R;
        Ch2=B;
        Ch3=G;
        [ICh3]=inter_channel_interploation(Ch1,Ch2,Ch3,N);
        
        % partly directional interpolation
        [IP]=calculate_interpolation_pixels(Ch3);
        
        % DCC interpolation
        k = 5; T = 1.15;
        level=1;
        OUTgo = Ch3(1:2^level:end-1,1:2^level:end-1);
        OUT = DCC(OUTgo,k,T);
        
        PSNR1=psnr(uint8(ICh3),Ch3);
        PSNR2=psnr(uint8(IP),Ch3);
        
        b=12;
        [~, ~, PSNR3] = Calc_MSE_SNR(Ch3,OUT,b);
        test_diff_interpolation_psnr(i,1)=PSNR1;
        test_diff_interpolation_psnr(i,2)=PSNR2;
        test_diff_interpolation_psnr(i,3)=PSNR3;
    end
%     test_diff_interpolation_psnr
%     save([save_path,'test_different_interpolation_img',num2str(cnt)],'img_arr');
%     save([save_path,'test_different_interpolation_test',num2str(cnt)],'test_diff_interpolation_psnr');
    
end