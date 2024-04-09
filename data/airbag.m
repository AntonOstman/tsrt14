function airbag

% AIRBAG Weight sensor signal from car seat used for airbag control
%
% Two data sets z1 and z2 taken from a weight
% sensor mounted in a car seat. The purpose is to decide when,
% given an accident, the airbag should be exploded with full
% pressure or reduced pressure, or not at all.
% Reduced pressure is suitable to use for light persons and
% children, or when the person is leaning forwards.
% The airbag should not be exploded when there is no person,
% or when a baby seat is detected.
%
% y1 is taken from a person of weight 70 kg entering and
% leaving the seat.
% y2 is in the same way taken from a person of weight 72 kg
% entering and leaving the seat, and not sitting still.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help airbag
load('airbag');
subplot(2,1,1)
plot(y1)
subplot(2,1,2)
plot(y2)
