function altdata

% ALTDATA Air pressure signal from pivot sensor in an aircraft
%
% The measurement error of one sensor for height of an aircraft
% based on barometric air pressure increases drastically for velocities
% around one Mach. It might be convenient to detect variance
% increases so the influence of these data can be decreased.
% Data are rescaled for confidentiality reasons

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help altdata
load altdata

plot(y)
