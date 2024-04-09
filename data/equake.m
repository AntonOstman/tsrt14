function equake

%EQUAKE Different seismic signals at the onset of an earthquake
%
% Earthquake data where each of the 14 columns shows one 
% measurement time series. A reference marker at time 610 is 
% included in the object.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $


help equake
load equake
plot(y(:,1:4))
figure
plot(y(:,5:8))
figure
plot(y(:,9:14))
