function [vm] = vertmoment(l,Ra,cp)

%matlab realisation of Macaulay notation

if l>=0 & l<=400
    vm = (- Ra)* (l/1000);
elseif l>=400 & l<=460
    vm = ((- Ra + cp)*(l/1000 - 0.4)) - (Ra*(l/1000)) ;
else 
    vm = 0;
end

end