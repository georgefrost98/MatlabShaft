function [vv] = vertshear(l,Ra,cp);

%matlab realisation of Macaulay notation

if l>=0 & l<=400
    vv = - Ra;
elseif l>=400 & l<=460
    vv = - Ra + cp;
else 
    vv = 0;
end
end

