function photons

%PHOTONS Detected photons in X-ray and gamma-ray observatories
%
% Number of 
% This is approximately a Poisson process with piecewise constant
% intensity. Alternatively, the time between arrivals is
% exponentially distributed with piecewise constant parameter.
% By downsampling, an approximate gaussian distribution with
% piecewise constant mean is obtained.
%
% The signals are
% y1  Index i gives the time of arrival of photon number i. The
%     time is an even integer which should be multiplied with 1 ms
%     to get actual time.
% y2  Value y2(i) is 1,2,3 or 4, and indicates the "color" of
%     photon i, classified in one of 4 energy channels of the
%     instrument.
% y3  Value y3(i) indicates that detector i (1-8) detected the
%     actual photon.
% The distribution of y1 is Poisson, except for that the intensity
% varies with time. There is also a dead time of 5 samples (10ms)
% in each detector.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help photons
load photons
plot(y(:,1))
