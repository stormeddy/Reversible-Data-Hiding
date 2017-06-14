function [Dest]=cal_Dest(DI,ind,gamma)
    [m,n]=size(DI);
    [i,j]=ind2sub([m,n],ind);
    t1=DI(i,j-1);
    t2=DI(i,j+1);
    t3=DI(i-1,j);
    t4=DI(i+1,j);
    SL=abs(t1-t2)-abs(t3-t4);
    
    if SL>=40
        type=1;
    else if SL>=20
            type=2;
        else if SL>=8
                type=3;
            else if SL>=0
                    type=4;
                else if SL>=-8
                        type=5;
                    else if SL>=-20
                            type=6;
                        else if SL>=-40
                                type=7;
                            else
                                type=8;
                            end
                        end
                    end
                end
            end
        end
    end
    Dest=gamma(type,1)*t1+gamma(type,2)*t2+gamma(type,3)*t3+gamma(type,4)*t4;

end