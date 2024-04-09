function ekg

%EKG Human EKG with and without 50 Hz disturbance
%
% An EKG signal showing human heart beats.
% s is the true EKG signal,
% y is a measurement suffering from a 50 Hz
% disturbance from the power supply.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help ekg
load ekg
subplot(2,1,1), plot(s)
subplot(2,1,2), plot(y)
