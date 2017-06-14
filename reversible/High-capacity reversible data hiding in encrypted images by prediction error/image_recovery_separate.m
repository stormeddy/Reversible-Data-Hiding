function [RI]=image_recovery_separate(DI,data_hiding_key,input_t)
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

    L=floor(numel(modify_ind)/1);
    
    gamma=[0.35 0.15 0.35 0.15;
        0.22 0.28 0.22 0.28;
        0.30 0.20 0.30 0.20;
        0.124 0.317 0.232 0.326;
        0.19 0.31 0.19 0.31;
        0.23 0.27 0.23 0.27;
        0.172 0.305 0.218 0.303;
        0.22 0.28 0.22 0.28];

    D0=DI;
    D1=DI;
    for i=1:L


    
        cur_ind=permute_modify_ind(i);
        
        [Dest]=cal_Dest(DI,cur_ind,gamma);
        D0(cur_ind)=bitset(DI(cur_ind),input_t,0);
        D1(cur_ind)=bitset(DI(cur_ind),input_t,1);

        ER0=abs(Dest-D0(cur_ind));
        ER1=abs(Dest-D1(cur_ind));
        if ER0>ER1

            RI(cur_ind)= D1(cur_ind);
        else
            RI(cur_ind)= D0(cur_ind);

        end
    end
end