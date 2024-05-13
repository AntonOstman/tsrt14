

mean(meas.acc(:, ~any(isnan(meas.acc), 1)), 2)

load xhat.mat
load meas.mat

subplot()