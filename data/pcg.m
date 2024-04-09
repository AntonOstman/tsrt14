function pcg

%PCG Human heart activity (phonocardiogram)
%
% In contrast to EKG, which shows electrical acitivity in the
% heart, the PCG (phonocardiogram) shows mechanical activity.
% A healthy heart shows a double beat ('dunk-dunk') for each heart
% beat, while unhealty ones show a 'whistle' inbetween these two
% ones.
% y1  Healthy heart beats (N=10001)
% y2  Unhealthy heart beats, decease type 1 (N=15000)
% y3  Unhealthy heart beats, decease type 2 (N=10000)
% Sampling frequency 2500Hz

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help pcg
load pcg
y1=resample(y1,10);
y2=resample(y2,10);
y3=resample(y3,10);
subplot(311), plot(y1)
subplot(312), plot(y2)
subplot(313), plot(y3)
