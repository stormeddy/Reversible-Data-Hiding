function I = rgbscaling(image,from,to,colorspace)

% input colorspace srgb by default

if ischar(from)
    from = getRefWhite(from,'rgb');
end
if ischar(to)
    to = getRefWhite(to,'rgb');
end


if ndims(image) ==3
    [n1,n2,n3] = size(image);
    image = reshape(image,n1*n2,n3);
    do_reshape = 1;
else
    do_reshape = 0;
end

if ~exist('colorspace','var')
    colorspace = 'srgb';
end

if ~strcmp(lower(colorspace),'rgb')
    eval(sprintf('image = %s2rgb(image);',lower(colorspace)));
end

if numel(to) == 2
    to(3) = 1-sum(to);
end

if numel(from) == 2
    from(3) = 1-sum(from);
end

if size(to,1) == 1
    to = to';
end
if size(from,1) == 1
    from = from';
end

M = diag(to./from);

I = image *M';

if ~strcmp(lower(colorspace),'rgb')
    eval(sprintf('I = rgb2%s(I);',lower(colorspace)));
end

if do_reshape
    I = reshape(I,n1,n2,n3);
end
