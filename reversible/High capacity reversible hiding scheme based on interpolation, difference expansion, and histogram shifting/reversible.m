% I=[160,160,160,160;
%    150,150,155,155;
%    150,150,150,150;
%    150,150,150,150];
% add_bits=[0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]';
% I=[153,165,197,161,179,138;161,117,119,171,154,165;177,188,109,189,100,159;160,125,170,160,120,177;172,136,109,187,144,117;143,130,120,168,156,150];
% add_bits=[0;1;1;1;0;1;1;0;0;1;0;1;0;0;1;0;0;1;0;1;1;0;0;1;1;1;0;0;0;0;0;1;1;1;0;0];

% I=randi([100 200],100,100);
% add_bits=randi([0 1],size(I));
% add_bits=add_bits(:);
% thres=10;

% result=0;
% EI=I;
% while true
% [EI,num,ratio]=data_embedding(EI,add_bits,thres)
% if ratio<=0
%     break;
% end
% result=result+ratio;
% end

% [EI,num,ratio,IP1,d_ref1]=data_embedding(I,add_bits,thres);
% [RI,extracted_bits,IP2,d_ref2]=data_extraction(EI,thres);
% 
% isequal(IP1,IP2)
% isequal(I,RI)
% isequal(add_bits(1:num),extracted_bits)
% find(I~=RI)
% find(IP1~=IP2)



clearvars
close all;
% I=imread('lena.pgm');
I=imread('lena.tiff');
min_val=min(I(:));
[m,n]=size(I);
add_bits=randi([0,1],m,n);
thres=0;

[EI,num,ratio,num_loc]=data_embedding(I,add_bits,thres);
[RI,extracted_bits]=data_extraction(EI,thres,num_loc);

isequal(I,RI)
actual_add_bits=add_bits(1:num)';
isequal(actual_add_bits,extracted_bits)

EI=uint8(EI);
psnr(EI,I)
ratio

figure(1)
imshow(I)
figure(2)
imshow(EI)