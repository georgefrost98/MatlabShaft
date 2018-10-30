function [hm] = horizmoment(l,Ra,Rc,Tts,cp);

%matlab realisation of Macaulay notation

L = l/1000;
if L>=0 & L<=0.05
    hm =  (Ra*L);
elseif L>=0.05 & L<=0.35
    hm =  (Ra*L) + (Tts*(L-0.05));
elseif L>=0.35 & L<=0.4
    hm =  (Ra*L) + (Tts*(L-0.05)) + (Tts*(L-0.35));
elseif L>=0.4 & L<=0.46
    hm =  (Ra*L) + (Tts*(L-0.05)) + (Tts*(L-0.35))+ (cp*(L-0.4));
else 
    hm = 0;
end
end