close all;
clearvars;
% path='4.2.0';
path='D:\Matlab\image_database\ucid\ucid';

save_path='para\';

for cnt=1:10
    cnt
    test_circular_interpolation_psnr=zeros(10,9);
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
        PSNR1_3=psnr(uint8(ICh3),Ch3);
        
        [ICh2]=inter_channel_interploation(Ch1,ICh3,Ch2,N);
        PSNR1_2=psnr(uint8(ICh2),Ch2);
        
        [ICh1]=inter_channel_interploation(ICh2,ICh3,Ch1,N);
        PSNR1_1=psnr(uint8(ICh1),Ch1);
        
        % partly directional interpolation
        [IP]=calculate_interpolation_pixels(Ch3);
        PSNR2_3=psnr(uint8(IP),Ch3);
        
        [IP]=calculate_interpolation_pixels(Ch2);
        PSNR2_2=psnr(uint8(IP),Ch2);
        
        [IP]=calculate_interpolation_pixels(Ch1);
        PSNR2_1=psnr(uint8(IP),Ch1);
        
        % DCC interpolation
        k = 5; T = 1.15;
        level=1;b=12;
        
        OUTgo = im2double(Ch3(1:2^level:end-1,1:2^level:end-1));
        OUT = im2uint8(DCC(OUTgo,k,T));        
        [~, ~, PSNR3_3] = Calc_MSE_SNR(Ch3,OUT,b);
        
        OUTgo = im2double(Ch2(1:2^level:end-1,1:2^level:end-1));
        OUT = im2uint8(DCC(OUTgo,k,T));         
        [~, ~, PSNR3_2] = Calc_MSE_SNR(Ch2,OUT,b);
        
        OUTgo = im2double(Ch1(1:2^level:end-1,1:2^level:end-1));
        OUT = im2uint8(DCC(OUTgo,k,T));       
        [~, ~, PSNR3_1] = Calc_MSE_SNR(Ch1,OUT,b);
        
        test_circular_interpolation_psnr(i,1)=PSNR1_3;
        test_circular_interpolation_psnr(i,2)=PSNR2_3;
        test_circular_interpolation_psnr(i,3)=PSNR3_3;
        
        test_circular_interpolation_psnr(i,4)=PSNR1_2;
        test_circular_interpolation_psnr(i,5)=PSNR2_2;
        test_circular_interpolation_psnr(i,6)=PSNR3_2;
        
        test_circular_interpolation_psnr(i,7)=PSNR1_1;
        test_circular_interpolation_psnr(i,8)=PSNR2_1;
        test_circular_interpolation_psnr(i,9)=PSNR3_1;
        
        i
    end
%     test_diff_interpolation_psnr
%     save([save_path,'test_circular_interpolation_img',num2str(cnt,'%02d')],'img_arr');
%     save([save_path,'test_circular_interpolation_test',num2str(cnt,'%02d')],'test_circular_interpolation_psnr');
    
end