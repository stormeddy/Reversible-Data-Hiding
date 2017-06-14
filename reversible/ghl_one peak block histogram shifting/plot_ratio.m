load('ratio.mat');
figure
x=1:1338;
plot(x,ratio1,'bo',x,ratio2,'r+',x,ratiomulti,'g*');
legend('single-level','double-level','multi-level','FontSize',10);
xlabel('Image number')
ylabel('Embedding capcity')