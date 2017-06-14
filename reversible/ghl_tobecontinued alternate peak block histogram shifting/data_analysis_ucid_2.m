% close all;
% clearvars;
% 
% load('ucid_diff_level_ratio.mat')
% [img_num,~]=size(ratio_at_diff_level);
% N=img_num;
% a=zeros(N,1);
% b=zeros(N,1);
% for i=1:img_num
%     level=1;
%     while(ratio_at_diff_level(i,level)>0)
%         level=level+1;
%     end
%     if level-1<2 %at least two levels
%         continue;
%     end
%     x=1:level-1;
%     y=ratio_at_diff_level(i,1:level-1);
%     ft=fit(x',y','exp1');
%     a(i)=round(ft.a*10000)/10000;
%     b(i)=round(ft.b*10000)/10000;
% end
N=1338;
scale_ucid=zeros(N,1);
for i=1:N
    if(ratio_at_diff_level(i)~=0)
        scale_ucid(i)=result(i)/ratio_at_diff_level(i);
    end
end