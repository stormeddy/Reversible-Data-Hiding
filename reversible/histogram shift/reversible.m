close all;
clearvars;

img='lena.pgm';
% img='.\img\cameraman.tif';
I=imread(img);
[counts,binLocations] = imhist(I);
add_bits=randi([0 1],max(counts),1);

% data embedding
[AI,max_px,min_px]=hist_embed(I,add_bits);

% data extraction
[RI,extract_bits]=hist_extract(AI,max_px,min_px);

error_ind=find(add_bits~=extract_bits);
ratio=numel(add_bits)/numel(I);

psnr(double(AI),double(I))
psnr(double(RI),double(I))