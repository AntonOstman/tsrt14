function [shat,res]=focus

%FOCUS Sensor network measurements of moving vehicles
%
% Sensor network data from the project FOCUS www.foi.se/focus
% There are 12 sensor nodes consisting of microphones and geophones,
% sampled with 4000 and 1000 Hz, respectively.
% Two vehicle trajectories are included, one with an motorcyle (MC),
% and one with a four-wheel drive vehicle (FW).
% There are 8 data files, consisting of permutations of FW/MC,
% geo/mic and ./raw. Raw means the the raw sensor measurements.
% Without raw, the signal is decimated energy with sampling frequency 1.
% The sensor model sm provides the sensor positions, and also the RSS1 model

load focus
xplot2(yMCmic)
hold on
plot(sm)


  [shat,res]=estimate(sm,yFWmic,'x0mask',zeros(sm.nn(1),1),'thmask',[zeros(sm.nn(4)-2,1);1;1],'maxiter',10,'disp','on');
