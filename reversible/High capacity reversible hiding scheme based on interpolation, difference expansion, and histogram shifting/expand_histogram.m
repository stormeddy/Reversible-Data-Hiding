function [I]=expand_histogram(I,thres,location_map)

    % preserve least significant N bits of modified pixels 
    N=ceil(log2(thres+1));
    [m,n]=size(I);
    % number of bits to represent pixel index
    ver_num_bit=ceil(log2(m));
    hor_num_bit=ceil(log2(n));
    
    num_loc=numel(location_map);
    ind=1;
    % location map is a column vector
    while ind<num_loc
       x=bin2dec(num2str(location_map(ind:ind+ver_num_bit-1)'))+1;
       ind=ind+ver_num_bit;
       y=bin2dec(num2str(location_map(ind:ind+hor_num_bit-1)'))+1;
       ind=ind+hor_num_bit;
       bit_values=location_map(ind:ind+N-1);
       for i=N:-1:1
        I(x,y)=bitset(I(x,y),i,bit_values(N+1-i),'uint8');
       end
       ind=ind+N;
    end

end