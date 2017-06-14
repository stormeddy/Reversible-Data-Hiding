close all;
clearvars;
encryption_key='matlab2dfbe56d4';



% figure(2)
% h=histogram(D);
% counts=h.Values;
% edges=h.BinEdges;
% [N,edges] = histcounts(D) ;

% I=[230 229 230 231; 228 229 232 230; 
%    229 232 231 230; 233 235 234 231];
% % add_bits=[1 1 0 0 1 1 1 1 0 0]';
% add_bits=randi([0 1],10,1);

I=imread('lena.tiff');
% I=randi([10 100],10,10);
add_bits=randi([0 1],numel(I),1);

L=1;
% [CI,H]=histogram_contraction(I,L);
% 
% [AI,ratio,ind]=data_embedding(CI,add_bits,L);

[AI,ratio,ind,len_H]=general_data_embedding(I,add_bits,L);
[RI,extract_bits]=general_data_extraction(AI,L,len_H);
% [TI,extract_bits]=data_extraction(AI,L);
% 
% isequal(TI,CI)
% 
isequal(RI,I)
isequal(extract_bits,add_bits(1:ind))
psnr(uint8(AI),uint8(I))
ratio

imshow(I)
figure,imshow(uint8(RI))
figure,imshow(uint8(AI))