close all;
clearvars;


permutation_key='0ahUKEwjPxaD8krTPAhVs_4MKHUY';
encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';
    
abso_path='D:\Matlab\image_database\image_gray\image_gray';
N=1338;

u=4;
v=4;
msb=1;

psnr_ucid_multi_level=zeros(N,1);

for i=1:N
    i
    path=[abso_path,num2str(i),'.tif'];
    I=imread(path); 

    [m,n]=size(I);
    k=0;
    AEI=I;
    total_add_bits=[];
    to_most=false;
    
    highest_level=31;
    while true
        
        k=k+1;
        % embed bits level k        
        pre_AEI=AEI;
        add_bits=randi([0 1],numel(AEI),1);
        disp(['embed at level ',num2str(k)]);
        [AEI,ratio,num]=general_embed(pre_AEI,u,v,msb,add_bits,permutation_key,encryption_key,data_hiding_key);
        if k==1 && ratio<0
            % cannot embed any bits
            disp('cannot embed any bits')
            break;
        end
        if k>1 && ratio<0
            to_most=true;
            disp(['can only embed up to level ',num2str(k-1)]);
            break;
        end
        if k==highest_level
            break
        end
    end
    if k==1
        % cannot embed any bits, cannot extract
        continue        
    end
    if to_most==true
        RI=pre_AEI;
    else
        RI=AEI;
        k=k+1;
    end

    while k>1        
        k=k-1;
        disp(['directly decrypt at level ',num2str(k)]);
        
        RJI=encrpyt_in_block_level(RI,encryption_key,u,v,msb);
   
        RI=reverse_permute_with_key(RJI,permutation_key,u,v);


    end
    psnr_ucid_multi_level(i)=psnr(RI,I);
    disp(['finish image',num2str(i)]);
    
end
    
% save('psnr_ucid_multi_level.mat','psnr_ucid_multi_level');
