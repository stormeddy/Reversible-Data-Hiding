I=imread('lena.tiff');
thres=10;
[CI,location_map]=shrink_histogram(I,thres);