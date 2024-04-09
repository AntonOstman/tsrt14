function ais2

% AIS2 Statistics on traffic injuries of category AIS2
%
% AIS2 is the risk of more than light injuries in traffic accidents
% The data here shows the risk for injuries during rear-end collisions
% between premium segment cars as a function of relative collision speed.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help ais2
load ais2

plot(y.t,y.y,'-o','linewidth',3)
set(gca,'xlabel','Relative collision speed','ylabel','Skaderisk','fontsize',18)
[y1,y2]=detrend(y,3);
hold on
plot(y2.t,y2.y,'-r','linewidth',3)
hold off
