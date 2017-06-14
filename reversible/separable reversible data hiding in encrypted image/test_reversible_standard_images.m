close all;
clearvars;

abso_path='D:\Matlab\image_database\test_grayscale_image\';
img_arr={'baboon.tiff','barbara.pgm','boat.pgm','crowd.tiff','plane.tiff',...
    'house.bmp','lena.tiff','peppers.tiff','lake.tiff','milkdrop.tiff','stream.tiff','tank.pgm'};
NN=numel(img_arr);

encryption_key='matlab2dfbe56d4';
data_hiding_key='howing-incorrect-resu';

result=zeros(NN,5,3,20);
reversibility=zeros(NN,5,3,20);
error_rate=zeros(NN,5,3,20);
direct_psnr=zeros(NN,5,3,20);

for i=1:NN
    i
    path=[abso_path,char(img_arr(i))];
    I=imread(path);
    
    [m,n]=size(I);
    for S=1:5
        for M=1:3
            j=1;
            while(true)
                L=100*j;
                L
                if(L>2000)
                    break;
                end
                
                % image encryption
                EI=my_crypt_rc4(I,encryption_key);
                
                % data embedding
                Np=cal_Np(M,L,S);
                N=m*n;
                add_bits=randi([0 1],floor((N-Np)*S/L)-Np,1);
                [AEI]=my_data_embedding(EI,data_hiding_key,add_bits,M,L,S);
                
                ratio=(floor((N-Np)*S/L)-Np)/N;
                
                % directly decrypted image (with only encrytion key)
                II=my_crypt_rc4(AEI,encryption_key);
                
                % data extraction with with both the keys
                [lenM,lenS,lenL,binM,binL,binS]=cal_len(M,L,S);
                [RI,extracted_add_bits]=extraction_both_keys(AEI,encryption_key,data_hiding_key,lenM,lenL,lenS);
                
                
                I=double(I);
                II=double(II);
                
                result(i,S,M,j)=ratio;
                reversibility(i,S,M,j)=1-(numel(find(RI~=I)))/numel(I);
                error_ind=find(add_bits~=extracted_add_bits);
                error_rate(i,S,M,j)=numel(error_ind)/numel(add_bits);
                direct_psnr(i,S,M,j)=psnr(II,I);
                
                if reversibility(i,S,M,j)==1 && error_rate(i,S,M,j)==0
                    break;
                end
                j=j+1;
            end
        end
    end
end
save('standard_imagess.mat','result','reversibility','error_rate','direct_psnr');




