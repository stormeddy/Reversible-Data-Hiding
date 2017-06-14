function [AI,max_px,min_px]=hist_embed(I,add_bits)
    % consider only one pair of maximum and minimum point
    [m,n]=size(I);
    len_m=length(num2str(m));
    len_n=length(num2str(n));
    
    [counts,binLocations] = imhist(I);
    
    [~,max_ind]=max(counts);
    max_px=binLocations(max_ind);
    
    [min_val,min_ind]=min(counts);
    
    
    min_indexes=find(counts==min_val);    
    % find the minimum point closest to the maximum point
    interval=numel(binLocations);% maximum possible index difference
    if numel(min_indexes)~=1
       for i=1:numel(min_indexes) 
           temp=abs(min_indexes(i)-max_ind);
           if(temp<interval)
               interval=temp;
               min_ind=min_indexes(i);
           end
       end
    end
    min_px=binLocations(min_ind);
    
    AI=I;
   
    add_ind=1;
    if(counts(min_ind)~=0)     
        % h(b)~=0
        b_indexes=find(I==min_px);
        overhead='';
        for i=1:numel(b_indexes)
            [xi,yi]=ind2sub([m,n],b_indexes(i));
            sxi=num2str(xi);
            syi=num2str(yi);
            while(length(sxi)<len_m) 
                sxi=strcat('0',sxi);
            end
            while(length(syi)<len_m) 
                syi=strcat('0',syi);
            end
            overhead=strcat(overhead,sxi,syi);
        end
        overhead=strcat(overhead,num2str(min_px));
        
        overnum=zeros(numel(overhead),1);
        for i=1:numel(overhead)
            overnum(i)=str2num(overhead(i));
        end
        
    end
    
    % embed additional bits to pixels with value max_px
    % determine the histogram shift direction
    if max_px<min_px
        between=(AI>max_px)&(AI<min_px);
        AI(between)=AI(between)+1;
        for i=1:m*n
            if AI(i)==max_px
                if add_bits(add_ind)==1
                    AI(i)=AI(i)+1;
                end
                add_ind=add_ind+1;
            end
        end
    else
        between=(AI>min_px)&(AI<max_px);
        AI(between)=AI(between)-1;
        for i=1:m*n
            if AI(i)==max_px
                if add_bits(add_ind)==1
                    AI(i)=AI(i)-1;
                end
                add_ind=add_ind+1;
            end
        end
    end
      
    
    ratio=(add_ind-1)/numel(I)
end