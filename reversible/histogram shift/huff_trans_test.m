% in=randi([0 7],1000,1);
% n=numel(unique(in));
% [out,dict]=huff_trans(in);
% 
% dsig = huffmandeco(out,dict);
% isequal(dsig,in)

img='.\img\cameraman.tif';
I=imread(img);
y=mat2lpc(I);
z=lpc2mat(y);
isequal(I,z)

HI=mat2huff(I);