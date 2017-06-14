function [p]=directional_interploation(p1,p2,p3,p4)
%
%     p1   p2                                      p1
%        p      (direction 45 and 135)   or    p2  p   p3  (direction 0 and 90)
%     p3   p4                                      p4
%

    % use directional interpolation
    % Lixin Luo, Zhang Xiong. Reversible image watermarking using interpolation technique.
    % IEEE Transaction on Information Forensics and Security 2010; 5(1): 187-193.
    d45=(p2+p3)/2;
    d135=(p1+p4)/2;
    miu=(p1+p2+p3+p4)/4;
    % sigma with 1/3 omitted
    sigma45=(p2-miu)^2+(p3-miu)^2+(d45-miu)^2;
    sigma135=(p1-miu)^2+(p4-miu)^2+(d135-miu)^2;
    if sigma45==0 && sigma135==0
        w45=0.5;
        w135=0.5;
    else
        w45=sigma135/(sigma45+sigma135);
        w135=sigma45/(sigma45+sigma135);
    end
    p=floor(w45*d45+w135*d135);
end