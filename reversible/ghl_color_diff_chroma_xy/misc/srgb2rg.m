function I = srgb2rg(image)

if numel(size(image)) == 3
    [n1,n2,n3] = size(image);
    image = reshape(image,n1*n2,n3);
    do_reshape = 1;
elseif numel(size(image)) == 2
    do_reshape = 0;
else
    error('wrong input dimensions');
end

image = srgb2linearrgb(image);
sum_image = sum(image,2);

image(:,3) = sum_image;

pos = sum_image>0;
I = double(image);
I(pos,1:2) = double(double(image(pos,1:2))./repmat(sum_image(pos),1,2));
I(~pos,1:2) = 1/3;     

if (do_reshape) 
    I = reshape(I,n1,n2,2);
end

