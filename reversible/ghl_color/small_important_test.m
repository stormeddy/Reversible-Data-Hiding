close all;
clearvars;
path='4.2.0';
for i=4:4
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    
    Ch1=R;
    Ch2=B;
    Ch3=G;
    N=500;
    add_bits=randi([0 1],numel(Ch3),1);

    
    
    [IP1]=inter_channel_interploation_non_sample(Ch3,Ch1,Ch2,N);
    
    [m,n]=size(Ch3);
    T=rand(m,n);
    T(1:2:end,1:2:end)=Ch3(1:2:end,1:2:end);
    
    [IP2]=inter_channel_interploation_non_sample(T,Ch1,Ch2,N);
    isequal(IP1,IP2)
end