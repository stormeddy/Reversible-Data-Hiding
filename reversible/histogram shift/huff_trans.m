function [out,dict]=huff_trans(in)
    % n: number of unique elements in the input
    N=numel(in);
    table=tabulate(in);
    
    pro=table(:,3)/100;
    symbols=table(:,1);
    [dict,avglen] = huffmandict(symbols,pro);
    out = huffmanenco(in,dict);
    
    binarySig = de2bi(in);
    seqLen = numel(binarySig)
    binaryComp = de2bi(out);
    encodedLen = numel(binaryComp)
end