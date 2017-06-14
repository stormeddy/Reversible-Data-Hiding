function [RI,extract_bits]=data_extraction_joint(DI,data_hiding_key,input_n,input_t)
    DI=double(DI);
    [m,n]=size(DI);
    RI=DI;
    sel_pxl=-ones(m,n);
    for i=2:m-1
        if mod(i,2)==0
            start=2;
        else
            start=3;
        end
        for j=start:2:n-1
            sel_pxl(i,j)=DI(i,j);
        end
    end
    modify_ind=find(sel_pxl~=-1);
    
    S=ksa(data_hiding_key);
    KSTREAM=prga_crypt(modify_ind,S);
    [~,index]=sort(KSTREAM(:));
    permute_modify_ind=modify_ind(index);

    N=numel(modify_ind);
    L=floor(N/input_n);
    extract_bits=zeros(L,1);
    gamma=[0.35 0.15 0.35 0.15;
           0.22 0.28 0.22 0.28;
           0.30 0.20 0.30 0.20;
           0.124 0.317 0.232 0.326;
           0.19 0.31 0.19 0.31;
           0.23 0.27 0.23 0.27;
           0.172 0.305 0.218 0.303;
           0.22 0.28 0.22 0.28];
    for i=1:L
            ER=0;
            ERf=0;
            for j=input_n*(i-1)+1:input_n*i
                
                cur_ind=permute_modify_ind(j);
                [Dest]=cal_Dest(DI,cur_ind,gamma);
                sel_pxl(cur_ind)=bitxor(sel_pxl(cur_ind),bitshift(1,input_t-1));
                
                ER=ER+abs(Dest-DI(cur_ind));
                ERf=ERf+abs(Dest-sel_pxl(cur_ind));
                
                
            end
            if ER>ERf
                % extracted bit is 1 and orignial pixel can be recovered by
                % flip t-th bit
                extract_bits(i)=1;
                for j=input_n*(i-1)+1:input_n*i
                    cur_ind=permute_modify_ind(j);
                    RI(cur_ind)= sel_pxl(cur_ind);
                end
                % else extracted bit is 0 and do not need to flip pixels
            end
    end
end