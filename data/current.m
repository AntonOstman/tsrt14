function current

%CURRENT Current in a power transformer after a network shortcut
%
% The data describes the current in a power transformer after
% a shortcut in the transformer at Soderasen in south Sweden, which
% let to a major network shutdown of large parts of Sweden.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help current
load current
subplot(2,1,1)
plot(y)
Y=ft(y);
subplot(2,1,2)
plot(Y,'Xlim',[0 120])
