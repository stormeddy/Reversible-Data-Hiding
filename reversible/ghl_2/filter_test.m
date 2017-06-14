thres_psnr=zeros(10,1);
for i=1:numel(thres_psnr)
    thres=10*i;
    FRI=filter_directly_decrypt_image(RI,thres,permutation_key,encryption_key,u,v,msb);
    thres_psnr(i,1)=psnr(double(FRI),double(I));
end



% [m,n]=size(RI);
% diff=zeros(m,n);
%     RI=double(RI);
%     for i=2:m-1
%         for j=2:n-1
%             tmp=RI(i-1:i+1,j-1:j+1);
%             diff(i,j)=abs(9*RI(i,j)-sum(tmp(:)));
%             
%         end
%     end