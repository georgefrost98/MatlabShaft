clear all
%%%%%%%%%%%%%%%%%%%%%%%%    establish variables    %%%%%%%%%%%%%%%%%%%%%%%%%%
T = 1820;                         %tension in chain (N)
cpv = T * sin(pi / 3);            %chain pull verticle
cph = -T * cos(pi / 3);           %chain pull horizontal
ab = 0.4;                         %distance from bearing (a) to sprocket (b)
bc = 0.06;                        %distance from sprocket (b) to  bearing (c)
at1 = 0.05;                       %distance from bearing (a) to track sprocket(t1)
at2 = 0.35;                       %distance from bearing (a) to track sprocket(t2)
P = 20e3;                         %Power (W)
w = 100 * pi;                     %angular velocity (rads^-1)
G = 76/23;                        %Gear ratio
Tdrive = P / w;                   %Torque on driving sprocket
Ttrans = G * Tdrive;              %Torque on transmission shaft
torque = [0,Ttrans/2,Ttrans/2,Ttrans,Ttrans,0]; %function defining the torque accross 6 nodes
d = [20,32,34,32,30,20];          %diameters of each node(mm)
i = (pi * (d/1000).^4)/64;        %Second moment of area  
j = i .* 2;                       %Polar second moment of area  



%%%%%%%%%%    Calculate Reactions (sprocket inside bearings)   %%%%%%%%%%%%%%

Tts = Ttrans / 0.290;                      %tension in track sprocket
Rav = cpv* (bc/0.46);                      %Reaction at a in vertical direction
Rcv = cpv* (ab/0.46);                      %Reaction at c in vertical direction
Rah = -(((cph*bc)+(Tts*0.11)+(Tts*0.41))/0.46);  %Reaction at a in horizontal direction
Rch = -(((cph*0.4)+(Tts*at1)+(Tts*at2))/0.46);   %Reaction at a in horizontal direction



%%%%%%%%%%%%%%%%%%% Calculate Bending moment & shear    %%%%%%%%%%%%%%%%%%
l = 0:500;
%{
for n = 1:length(l)
    vv(n) = vertshear(l(n),Rav,cpv);      %don't really need these 
end
%}
for n = 1:length(l)
    vm(n) = vertmoment(l(n),Rav,cpv);
end
%{
for n = 1:length(l)
    hv(n) = horizshear(l(n),Rah,Rch,Tts,cph);  %don't really need these
end
%}
for n = 1:length(l)
    hm(n) = horizmoment(l(n),Rah,Rch,Tts,cph);
end



%%%%%%%%%%%%%%%%%%%%  Calculate max moments  %%%%%%%%%%%%%%%%%%%%%%%%%%%
vms = vm.^2;
hms = hm.^2;
bm = (vms + hms).^0.5;
%position of each node from centreline of first bearing
L1 = 9;           
L2 = 69;
L3 = 331;        
L4 = 378;
L5 = 451;
L6 = 481; %end of shaft 

nodehoriz = [min(hm(1:L1)),min(hm(L1:L2)),min(hm(L2:L3)),min(hm(L3:L4)),min(hm(L4:L5)),min((L5:L6))]; %horizontal max moment

nodevert = [min((1:L1)),min(vm(L1:L2)),min(vm(L2:L3)),min(vm(L3:L4)),min(vm(L4:L5)),min(vm(L5:L6))];   %vertical max moment

noderesultant = [max(bm(1:L1)),max(bm(L1:L2)),max(bm(L2:L3)),max(bm(L3:L4)),max(bm(L4:L5)),max(bm(L5:L6))];  %resultant max moment

%%%%%%%%%%%%%%%%%   principle stress    %%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ts = (torque .* (d/2000))./j;  %gives a vector of torsional stress
Bs = (noderesultant .* (d/2000))./i;

Ssquared = Bs.^2;
Tsquared = Ts.^2;

maxstress = 0.5 * (Ssquared + (4*Tsquared)).^0.5; %max stress in each node
Mpa = maxstress / 1e6;      %gives answer in MPa


%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%plot(l,vm)
%title('Bending moment diagram')
%hold on
%plot(l,hm)
%grid on 
%ylabel('Bending moment /Nm')
%xlabel('distance from centreline of bearing /mm')

%plot(l,bm)
%grid on 
%title('resultant Bending moment diagram')
%ylabel('Bending moment /Nm')
%xlabel('distance from centreline of bearing /mm')









