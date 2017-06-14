% t=0:0.005:1;
% x=(1+t)./(4+3*t);
% y=x;
% z=(2+t)./(4+3*t);
% figure
% plot3(x,y,z)
%结果就是一条直线

a=[2 4 1];
m=[-1 0 2];
l=[2 2 -3];
ma=a-m;
d=norm(cross(ma,l))/norm(l);
d