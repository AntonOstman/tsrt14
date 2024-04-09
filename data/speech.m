function speech

% SPEECH Speech data recorded inside a car
%
% It has been analysed by Regine Andre-Obrecht (1988) and her
% results are also published in Basseville and Nikiforov (1993).
% The first data batch contains low-frequency noise from the car
% and the other is a prefiltered version.
% fs=8 kHz.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $


help speech

load speech
subplot(211)
uplot(y)
title('Noisy speech signal')
subplot(212)
yplot(y)
title('Filtered speech signal')
