close all;
clearvars;

img='lena.pgm';
I=imread(img);
[counts,binLocations] = imhist(I);
add_bits=randi([0 1],max(counts),1);

% data embedding
[AI,max_px,min_px]=hist_embed_multi(I,add_bits);

% data extraction
[RI,extract_bits]=hist_extract(AI,max_px,min_px);

error_ind=find(add_bits~=extract_bits);

psnr(double(AI),double(I))
psnr(double(RI),double(I))