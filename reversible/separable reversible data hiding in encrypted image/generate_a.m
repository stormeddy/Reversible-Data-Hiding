function [A]=generate_a(S)
    A=zeros(2^S,S);
    for i=1:S
        A(:,i)=repmat([zeros(2^(i-1),1);ones(2^(i-1),1)],2^(S-i),1);
    end
end