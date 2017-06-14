NN=12;
L=zeros(NN,15);
psnr=zeros(NN,15);
ec=zeros(NN,15);
rev=zeros(NN,15);
for i=1:NN
    ind=1;
    for S=1:5
        for M=1:3
            j=1;
            while(reversibility(i,S,M,j)<1)
                if(j==20) 
                    break;
                end
                j=j+1;
            end
            L(i,ind)=j*100;
            psnr(i,ind)=direct_psnr(i,S,M,j);
            ec(i,ind)=result(i,S,M,j);
            rev(i,ind)=reversibility(i,S,M,j);
            ind=ind+1;
        end
    end
end