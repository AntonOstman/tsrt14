%SNIPER Data from sensor network for detecting snipers

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

close all
load('sniper');
M=length(p);
x0=[s0(1,1) s0(1,2) 0 c v0 a0(1)]
smod=sensormod('sniper1',[6 0 2*M 2*M]);
p=p';
smod.th=p(:);
smod.x0=x0;
smod.pe=0.1*eye(2*M);
smod
plot(smod,'xind',[1 2])
axis([-400 100 -100 100])
axis('equal')
%%
y=simulate(smod,0);
y.y
figure
xcrlb=crlb(smod)
lh2(smod,y,-190+[-20:1:20],30+[-20:1:20]);
hold on
xhat=wls(smod,y);
xplot2(xcrlb,xhat,'conf',90)
