function sheep

%SHEEP Air pressure and volume in a sheep lung subject to asthma medicine.
%
% Data y and u from measurements of air pressure and air volume in
% the lung of a sheep subject to asthma medicine. The belches
% create a high pressure that deteriorates any attempt to system
% identification. These segments must be detected before
% identification.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help sheep
load sheep
plot(y)
