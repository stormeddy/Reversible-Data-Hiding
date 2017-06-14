function d=cal_diff(I)
    sI=inverse_s_order(I);
    N=numel(sI);
    d=zeros(N,1);
    d(1)=sI(1);
    for i=2:N
        d(i)=abs(sI(i-1)-sI(i));
    end
end