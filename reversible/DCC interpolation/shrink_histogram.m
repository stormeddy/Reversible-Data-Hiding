function [CI,location_map]=shrink_histogram(I,thres)
    % preserve least significant N bits of modified pixels 
    N=ceil(log2(thres+1));
    [m,n]=size(I);
    % number of bits to represent pixel index
    ver_num_bit=ceil(log2(m));
    hor_num_bit=ceil(log2(n));
    location_map=[];
    CI=I;
    for i=1:m
        for j=1:n
            if I(i,j)<thres+1
                location_map=[location_map,de2bi(i-1,'left-msb',ver_num_bit)];
                location_map=[location_map,de2bi(j-1,'left-msb',hor_num_bit)];
                location_map=[location_map,bitget(I(i,j),N:-1:1,'uint8')];
                CI(i,j)=thres+1;
                
            else
                if I(i,j)>255-(thres+1)
                location_map=[location_map,de2bi(i-1,'left-msb',ver_num_bit)];
                location_map=[location_map,de2bi(j-1,'left-msb',hor_num_bit)];
                location_map=[location_map,bitget(I(i,j),N:-1:1,'uint8')];
                CI(i,j)=255-(thres+1);
                
                end
            end
        end
    end
end