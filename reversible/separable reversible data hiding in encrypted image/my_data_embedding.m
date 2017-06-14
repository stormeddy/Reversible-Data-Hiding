function [AEI]=my_data_embedding(EI,data_hiding_key,add_bits,M,L,S)
    % EI: encrypted image
    % add_bits: additional bits
    % M: number of least significant bits,M<5
    % L: number of pixels in each group
    % S: a small positive integer
    
    AEI=EI;
    % generate sequence according to the data hiding key
    Str=ksa(data_hiding_key);
    kblk=prga_crypt(AEI,Str);
    [kblk_m,kblk_n]=size(kblk);
    
    kstr=kblk(:);
    N=numel(AEI);
    [~,index]=sort(kstr);
    
    [lenM,lenS,lenL,binM,binL,binS]=cal_len(M,L,S);    
    Np=lenM+lenL+lenS;
    
    orig_bits=zeros(Np,1);
    for i=1:Np
       orig_bits(i)=bitget(AEI(index(i)),1); 
    end
    
    % embed M,L,S, MSB prior to LSB
    for i=1:lenM
        AEI(index(i))=bitset(AEI(index(i)),1,str2double(binM(i)));        
    end
    
    for i=1:lenL
        AEI(index(i+lenM))=bitset(AEI(index(i+lenM)),1,str2double(binL(i)));        
    end
    
    for i=1:lenS
        AEI(index(i+lenM+lenL))=bitset(AEI(index(i+lenM+lenL)),1,str2double(binS(i)));        
    end
    
    
    % generate matrix Q according to the data hiding key
    Q=zeros(M*L-S,S);
    QStr=ksa(data_hiding_key);
    Q=prga_crypt(Q,QStr);
    Q=bitand(Q,1);% convert to binary matrix
    G=[eye(M*L-S) double(Q)];
    
    add_bits_index=0;
    % extend the number of add_bits to floor((N-Np)*S/L) by adding original LSB of selected
    % encrypted pixels, but the number of additinal bits is still floor((N-Np)*S/L)-Np
    add_bits=[add_bits;orig_bits];
    B=zeros(M*L,floor((N-Np)/L));
    Bp=zeros(M*L,floor((N-Np)/L));
    for i=1:floor((N-Np)/L);
        B_index=1;
        for j=(i-1)*L+1+Np:i*L+Np
            for k=M:-1:1
                B(B_index,i)=bitget(AEI(index(j)),k);
                B_index=B_index+1;
            end
        end
        Bp(1:M*L-S,i)=mod(G*B(:,i),2);
        Bp(M*L-S+1:M*L,i)=add_bits(add_bits_index+1:add_bits_index+S);
        add_bits_index=add_bits_index+S;        
    end
    
    % ignore next 3 lines! It was my fault.
    % the last ceil(Np/S) columns of Bp store the original LSB of selected
    % encrypted pixels instead of additional bits
    % Bp(M*L-Np+1:M*L,floor((N-Np)/L))=orig_bits;
    
    % replace the orignial M LSB of encrypted pixels
    for i=1:floor((N-Np)/L);
        B_index=1;
        for j=(i-1)*L+1+Np:i*L+Np
            for k=M:-1:1
                AEI(index(j))=bitset(AEI(index(j)),k,Bp(B_index,i));
                B_index=B_index+1;
            end
        end       
    end
    
    AEI=uint8(reshape(AEI,kblk_m,kblk_n)); 
    
    
    
end