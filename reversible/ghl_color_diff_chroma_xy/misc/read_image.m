% [I,mask] = read_image(filename,imdir)
%
% interface to read an image and a corresponding mask of the color
% check chart.
%
% IMPORTANT: You need to edit the file and give the correct link to
% the coordinates directory of the ColorChecker Database. 
function [I,mask] = read_image(filename,imdir)

if ~strcmp(imdir(end),'/')
    imdir(end+1) = '/';
end

I = imread(['~/colorconstancy/ColorCheckerDatabase/' imdir filename]);

if nargout > 1

    fname = strrep(filename,'.tif','_macbeth.txt');
    % you must provide the correct link to the coordinates
    % directory here.
    dat = load(['~/colorconstancy/ColorCheckerDatabase/coordinates/' fname]);

    if size(dat,1) ~= 101 || size(dat,2) ~=2 
	error('coordinate data in invalid format')
    end

    n2 = dat(1,1);
    n1 = dat(1,2);

    [nn1,nn2,nn3] = size(I);

    if nn2~=n2
	dat(:,1) = dat(:,1) * nn1/n1;
	dat(:,2) = dat(:,2) * nn2/n2;
    end
    
    dat(1,:) = [];
    
    mask = getMask(I,dat(1:4,:));
end

