function [RI,extracted_add_bits]=extraction_both_keys(AEI,encryption_key,data_hiding_key,lenM,lenL,lenS)
    % generate sequence according to the data hiding key
    Str=ksa(data_hiding_key);
    kblk=prga_crypt(AEI,Str);
    kstr=kblk(:);
    N=numel(AEI);
    [~,index]=sort(kstr);
    
    % get the value of M,L,S
    Np=lenM+lenL+lenS;
    bits_MLS=zeros(Np,1);
    for i=1:Np
        bits_MLS(i)=bitget(AEI(index(i)),1);
    end
    
    m_str='';
    for i=1:lenM
        m_str=strcat(m_str,num2str(bits_MLS(i)));
    end
    M=bin2dec(m_str);
    
    l_str='';
    for i=1:lenL
        l_str=strcat(l_str,num2str(bits_MLS(i+lenM)));
    end
    L=bin2dec(l_str);
    
    s_str='';
    for i=1:lenS
        s_str=strcat(s_str,num2str(bits_MLS(i+lenM+lenL)));
    end
    S=bin2dec(s_str);
    
    % extract S embedded bits from M LSB-planes of each group
    extraction=zeros(floor((N-Np)*S/L),1);    
    add_bits_index=0;
    
    Bp=zeros(M*L,floor((N-Np)/L));
    for i=1:floor((N-Np)/L);
        B_index=1;
        for p=(i-1)*L+1+Np:i*L+Np
            for k=M:-1:1
                Bp(B_index,i)=bitget(AEI(index(p)),k);
                B_index=B_index+1;
            end
        end        
        extraction(add_bits_index+1:add_bits_index+S)=Bp(M*L-S+1:M*L,i);
        add_bits_index=add_bits_index+S;        
    end   
    
    extracted_add_bits=extraction(1:floor((N-Np)*S/L)-Np);

    
    encrypt_s=ksa(encryption_key);
    encrypt_kstream=prga_crypt(AEI,encrypt_s);
    
    % directly decrypted image using encryption key
    DI=my_crypt_rc4(AEI,encryption_key);
    
    
    RI=DI;
    % the original LSB of selected encrypted pixels
    orig_bits=extraction(floor((N-Np)*S/L)-Np+1:floor((N-Np)*S/L));
    for i=1:Np
        RI(index(i))=bitxor(bitset(AEI(index(i)),1,orig_bits(i)),encrypt_kstream(index(i)));
    end
    
    % generate all the possible vectors A
    [A]=generate_a(S);
    
    % generate matrix Q according to the data hiding key
    Q=zeros(M*L-S,S);
    QStr=ksa(data_hiding_key);
    Q=prga_crypt(Q,QStr);
    Q=bitand(Q,1);% convert to binary matrix
    H=[double(Q') eye(S)];
    
    
    DI=double(DI);
    
    for i=1:floor((N-Np)/L)
        D=zeros(2^S,1);
        T=zeros(L,2^S);
        for p=1:2^S            
            v=mod([Bp(1:M*L-S,i);zeros(S,1)]'+mod(A(p,:)*H,2),2);
            B_index=1;
            T_index=1;
            % put the elements in v to the original positions and decrypt
            % using the encryption key and calculate D at the same time
            for j=(i-1)*L+1+Np:i*L+Np
                % index(j) stores the bits' original position in the image
                T(T_index,p)=AEI(index(j));
                for k=M:-1:1                    
                    T(T_index,p)=bitset(T(T_index,p),k,v(B_index));
                    B_index=B_index+1;
                end
                % decrypt T
                T(T_index,p)=bitxor(T(T_index,p),encrypt_kstream(index(j)));
                
                % calculate D, all 2^s possible results
                orig_index=index(j);
                est_p=cal_p(DI,orig_index,M);
                D(p)=D(p)+abs(T(T_index,p)-est_p);
                
                T_index=T_index+1;
            end           
        end 
        [~,min_index]=min(D);
        T_index=1;
        for j=(i-1)*L+1+Np:i*L+Np
            RI(index(j))=T(T_index,min_index);
            T_index=T_index+1;
        end
        
    end
    
end