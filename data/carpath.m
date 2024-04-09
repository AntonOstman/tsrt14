function carpath

%CARPATH Car position obtained by dead-reckoning of wheel velocities
%
% Compare with the wheel speeds with GPS reference in the SIG object odometry 
%
% x1,x2 = position
% v     = velocity
% psi   = heading angle
% y     = psi
% phi   = [ones(size(t)) t];
% z     = [y phi]

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help carpath
load carpath
xplot2(y)
