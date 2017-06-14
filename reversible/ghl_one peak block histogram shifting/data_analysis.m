close all
scale=result./ratio_at_diff_level(:,1);
scale_mean=mean(scale);

img_arr={'Baboon','Barbara','Boat','Crowd','F16',...
    'House','Lena','Peppers','Sailboat','Splash','Stream','Tank'};
N=numel(img_arr);

a=zeros(N,1);
b=zeros(N,1);
for i=1:12
    h=figure(i);
    level=1;
    while(ratio_at_diff_level(i,level)>0)
        level=level+1;
    end
    x=1:level-1;
    y=ratio_at_diff_level(i,1:level-1);
    ft=fit(x',y','exp1');
    a(i)=round(ft.a*10000)/10000;
    b(i)=round(ft.b*10000)/10000;
    plot(x,y,'o',x,ft(x))
    title(img_arr{i});
    formula=['$$y=',num2str(a(i)),'e^{',num2str(b(i)),'x}$$'];
    
    legend({'actual ratio','fitting curve'});
    pos=(level-1)/2;
    text(pos,ft(pos)*1.5,formula,'Interpreter','latex','fontsize',15)
    xlabel('x:level');
    ylabel('y:ratio');
    saveas(gcf,['figure\',img_arr{i},'_ratio_change.eps']);
    close(h);
end

save('figure\scale.mat','scale');
save('figure\a.mat','a');
save('figure\b.mat','b');