close all;
clearvars;
encryption_key='matlab2dfbe56d4';
I=imread('lena.pgm');
figure(1)
imhist(I)
D=cal_diff(I);

figure(2)
h=histogram(D);
counts=h.Values;
edges=h.BinEdges;
% [N,edges] = histcounts(D) ;

% omitted
% almost the same as REVERSIBLE IMAGE AUTHENTICATION BASED ON WATERMARKING
% except for the adoption of modulo arithmetic