function reaction

%REACTION Chemical reaction with temperature as input
%
% The same experiment is done with three different temperatures

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help reaction
load reaction
yplot(y1,y2,y3)
legend(['T = ',num2str(y1.u(1))],['T = ',num2str(y1.u(2))],['T = ',num2str(y1.u(3))])
