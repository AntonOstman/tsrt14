function auv

% AUV Simulated UAV speed, heading and turn rate as a function of rudder angle
%
% The yaw dynamics of an UAV has been simulated by the model
% m=exnl('uav') given in
%
%    Estimation of AUV dynamics for sensor fusion
%    K.M. Fauske, F. Gustafsson and O. Hegrenaes
%    Fusion 2007, Quebec, Canada
%
% The input is a realistic rudder deflection signal, and
% measurement noise has been added to the output.
%
% The animation, started with play(y), has been provided by
% Kjell Magne Fauske.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help auv
load auv

plot(y(:,1:2))
figure
xplot2(y)
