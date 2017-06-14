function print_big_integer_matrix(EI)
    m=EI.length;
    n=EI(1).length;
    for i=1:m
        for j=1:n
            disp(EI(i,j).toString());
        end
    end
end