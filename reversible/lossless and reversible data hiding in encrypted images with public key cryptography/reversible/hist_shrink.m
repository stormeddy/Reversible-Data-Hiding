function [IT]=hist_shrink(I,del)
    % histogram shrink
    [counts,~]=imhist(I);
    bs1='';
    for i=1:del+2
        if(counts(i)>0)
            bs1=strcat(bs1,repmat(dec2bin(i,8),1,counts(i)));
        end
    end
    
    bs2='';
    for i=256-del:256
        if(counts(i)>0)
            bs2=strcat(bs2,repmat(dec2bin(i,8),1,counts(i)));
        end
    end
    IS=I;
    IS(IS<=del+1)=del+1;
    IS(IS>=255-del)=255-del;
    
    
    [new_counts,~]=imhist(IS);
    [~,V]=max(new_counts);
    V=V-1;
    
    % [m,n]=size(I);
    sec_set=find(IS>floor(V/2),8);
    % fir_set=setdiff([1:m*n]',sec_set,'stable');

    % original LSB of the second set
    sec_lsb='';
    for i=1:numel(sec_set)
       sec_lsb=strcat(sec_lsb,num2str(bitget(IS(sec_set(i)),1)));
    end
    
    % embed bs1,bs2,the LSB of pixels int the second set into 
    shr_bit=strcat(bs1,bs2,sec_lsb);
    IT=IS;
    IT(IT<V)=IS(IS<V)-1;
    V_ind=find(IS==V);
    for i=1:numel(shr_bit)
       if(shr_bit(i)=='1')
           IT(V_ind(i))=V-1;
       end
    end
    
    % embed V into the LSB of the second set
    V_bin=dec2bin(V,8);
    for i=1:8
        if(bitget(IS(sec_set(i)),1)~=V_bin(i))
            IT(sec_set(i))=IS(sec_set(i))-1;
        end
    end
    
end