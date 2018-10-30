function [hv] = horizshear(l,Ra,Rc,Tts,cp);

%matlab realisation of Macaulay notation

if l>=0 & l<=50
    hv =  Ra;
elseif l>=50 & l<=350
    hv =  Ra + Tts;
elseif l>=350 & l<=400
    hv =  Ra + (2*Tts);
elseif l>=400 & l<460
    hv =  Ra + (2*Tts)+ cp;
elseif l==460
    hv =  Ra + (2*Tts)+ cp + Rc;
else 
    hv = 0;
end
end