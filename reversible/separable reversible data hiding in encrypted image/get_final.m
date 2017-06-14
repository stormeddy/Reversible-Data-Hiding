NN=12;
final=zeros(NN,5);
for i=1:NN
    [max_ec,ind]=max(ec(i,:));
    k=rem(ind,3);
    if k==0
        final(i,1)=3;
    else
        final(i,1)=k;
    end
    final(i,2)=floor(ind/3);
    final(i,3)=L(i,ind);
    final(i,4)=ec(i,ind);
    final(i,5)=psnr(i,ind);
    final(i,6)=final(i,2)/final(i,3);
    final(i,7)=final(i,4)*512*512;
end