function [extracted_add_bits]=extraction_data_hiding_key(AEI,data_hiding_key,lenM,lenL,lenS)
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
        for j=(i-1)*L+1+Np:i*L+Np
            for k=M:-1:1
                Bp(B_index,i)=bitget(AEI(index(j)),k);
                B_index=B_index+1;
            end
        end        
        extraction(add_bits_index+1:add_bits_index+S)=Bp(M*L-S+1:M*L,i);
        add_bits_index=add_bits_index+S;        
    end
    
    extracted_add_bits=extraction(1:floor((N-Np)*S/L)-Np);
    
end