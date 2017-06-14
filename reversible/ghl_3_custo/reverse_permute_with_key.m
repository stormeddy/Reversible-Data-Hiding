function [RI]=reverse_permute_with_key(RJI,permutation_key,u,v)
    % RJI: image after reverse Josephus traverse
    
    % reverse Josephus traverse
    [m,n]=size(RJI); 
    hor_num=floor(m/u);
    ver_num=floor(n/v);
    
    f=zeros(hor_num,ver_num);
    S=ksa(permutation_key);
    KSTREAM=prga_crypt(f,S);
    [~,index]=sort(KSTREAM(:));   
    
    
    B=1:hor_num*ver_num;
    Bp=B(index);
    
    
    RI=RJI;
    len_key=length(permutation_key);
    
    for i=1:hor_num*ver_num
       ind=Bp(i);
       [x,y] = ind2sub([hor_num,ver_num],ind);
       [xi,yi] = ind2sub([hor_num,ver_num],i);
       tmp=RJI((xi-1)*u+1:xi*u,(yi-1)*v+1:yi*v);
       % permute within differendt blocks with different keys
       % different keys are generated by strcat(...)
       ptmp=reverse_permute_within_block(tmp,strcat(permutation_key,permutation_key(mod(ind,len_key)+1)));
       RI((x-1)*u+1:x*u,(y-1)*v+1:y*v)=ptmp;
    end
    
    

end