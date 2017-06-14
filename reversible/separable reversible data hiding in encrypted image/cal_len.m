function [lenM,lenS,lenL,binM,binL,binS]=cal_len(M,L,S)
    binM=dec2bin(M);
    binL=dec2bin(L);
    binS=dec2bin(S);
    lenM=length(binM);
    lenL=length(binL);
    lenS=length(binS);
end