a=[1/2 1/2 1/2];
% 和matlab自带不一致
% 要先进行一个RGB->sRGB的转换
p=rgb2xyz(a);
p_norm=p/sum(p(:))
q=my_rgb2xyz(a);
q_norm=q/sum(q(:))
% isequal(p_norm,q_norm)

pa=xyz2rgb(p)
qa=my_xyz2rgb(q)
% isequal(pa,qa)

M=[0.49 0.31 0.20;
   0.17697 0.81240 0.01063;
   0 0.01 0.99];
M=M/0.17697;

r=M*a';
r_norm=r/sum(r);
