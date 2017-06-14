k = 5; T = 1.15;
level=1;b=12;
Ch2=imread('lena.pgm');
OUTgo = im2double(Ch2(1:2^level:end-1,1:2^level:end-1));
OUT = im2uint8(DCC(OUTgo,k,T));         
[~, ~, PSNR3_2] = Calc_MSE_SNR(Ch2,OUT,b);