


%% round tourht
clear
load("RealG3.mat")
plot(position(:,2),position(:,3))
clear
%%
%% Task 7.1 Calculate the normal distribution parameters
clear
load("calibration_data.mat")
% we know where the car is
% we know how long a beep should take to arrive
% since the car is still, each measure should be 0.5 away from the next
% using this we can get the error
errors = zeros(8,24);

for i = 1:size(tphat,2) - 1
    errors(:,i) = tphat(:,i + 1) - tphat(:,i);
end
chirp_interval = 0.5;
errors = errors - chirp_interval;
sel_err = errors(6,:);
err_mean = mean(sel_err);
err_std = std(sel_err);

histfit(sel_err)

%%