function nose

%NOSE Data from an electronic 'nose' subject to different bacteria
%
% Measurements from an electronic 'nose' subject to different bacteria
% There are 90 differents tests, each one with a sig object.
% Each test saves 18 samples from 15 sensors.
% There are 15 sensors, each sensor gives a time response of 18
% samples to each test. There are 90 tests all in all from 10
% different bacteria. The first column to each test contains the
% class. The model described in modelnose can be used in a
% model-based feature extraction for classification.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help nose
load nose
k=1;
plot(y{k}(:,11:15))
xlabel(['Test ',num2str(k),'  Class ',num2str(10*y{k}.y(1,1))])
