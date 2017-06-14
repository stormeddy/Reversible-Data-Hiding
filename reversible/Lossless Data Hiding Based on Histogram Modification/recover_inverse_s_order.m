function AI=recover_inverse_s_order(y,m,n)
    sy=reshape(y,m,n);
    for i=2:2:n
        sy(:,i)=flipud(sy(:,i));
    end
    AI=sy';
end