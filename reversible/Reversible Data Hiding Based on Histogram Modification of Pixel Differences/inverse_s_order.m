function sI=inverse_s_order(I)
    sI=I';
    [m,n]=size(sI);
    for i=2:2:n
        sI(:,i)=flipud(sI(:,i));
    end
    sI=sI(:);
end