A=im2double(uint8([185 93 48]));
B=im2double(uint8([191 96 46]));
a=my_rgb2xyz(A);
b=my_rgb2xyz(B);
a
b
% an=a/sum(a)
% bn=b/sum(b)
