close all;
clearvars;
path='4.2.0';
for i=7:7
    img=[path,num2str(i),'.tiff'];
    I=imread(img);
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    
    diff_R_G=double(R)-double(G);
    diff_B_G=double(B)-double(G);
    
end

figure(5)
imshow(diff_R_G,[])

figure(6)
imshow(diff_B_G,[])

figure(4)
imshow(I)

figure(1)
imshow(I(:,:,1))

figure(2)
imshow(I(:,:,2))

figure(3)
imshow(I(:,:,3))