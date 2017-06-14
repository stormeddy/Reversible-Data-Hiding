function [Np]=cal_Np(M,L,S)
    binM=dec2bin(M);
    binL=dec2bin(L);
    binS=dec2bin(S);
    lenM=length(binM);
    lenL=length(binL);
    lenS=length(binS);
    Np=lenM+lenL+lenS;

end