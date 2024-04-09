function gaze

%GAZE Two video cameras monitor eye movements of a car driver
%
% Gaze angles of a car driver from two video cameras
% Data z=[y1 y2] for a change in the mean model
%   /y1\   / th1 \   /e1\
%   |  | = |     | + |  |
%   \y2/   \ th2 /   \e2/
% The measurements y1 and y2 come from two video cameras where
% an image processing algorithm computes the horizontal and
% vertical angle of vision of a driver. The purpose is to
% monitor the driver's behavior, like watching the rear mirror
% or dash board, which corresponds to segments of constant
% angles.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help gaze
load gaze
plot(y)
figure
xplot2(y(1:100))
