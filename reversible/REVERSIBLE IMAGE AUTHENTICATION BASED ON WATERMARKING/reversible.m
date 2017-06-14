close all;
clearvars;
encryption_key='matlab2dfbe56d4';
% I=imread('lena.pgm');
I=imread('lena.tiff');
figure(1)
imhist(I)
D=cal_diff(I);

figure(2)
h=histogram(D);
counts=h.Values;
edges=h.BinEdges;
% [N,edges] = histcounts(D) ;


add_bits=randi([0 1],numel(I),1);
[AI,ratio,ind]=data_embedding(I,add_bits);
[RI,extract_bits]=data_extraction(AI);

isequal(RI,I)
isequal(extract_bits,add_bits(1:ind))
psnr(AI,I)