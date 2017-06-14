function I_arr=divide_image(I)
    [m,n,~]=size(I);
    I_arr=cell(4,1);
    I_arr{1}=I(1:floor(m/2),1:floor(n/2),:);
    I_arr{2}=I(1:floor(m/2),1+floor(n/2):n,:);
    I_arr{3}=I(1+floor(m/2):m,1:floor(n/2),:);
    I_arr{4}=I(1+floor(m/2):m,1+floor(n/2):n,:);

end