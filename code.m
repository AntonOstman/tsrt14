


%% round tourht
%clear
load("RealG3.mat")
plot(position(:,2),position(:,3))
%clear
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
sel_err = errors;
err_mean = mean(sel_err, 2);
err_std = std(sel_err, 0, 2);

%histfit(sel_err)

%%

%% Task 7.2
% hx = TDOA measurements
% 
%%
%% Task 7.3
%The good microphones are in a circle around the robot
% The bad ones are in a straight line looking towards the robot

%%
%% Task 7.4

load("dataset.mat")

sm = exsensor('tdoa1', 4,1)
sm.x0 = [0 0 0]
%mic_range = 5:8;
mic_range = 1:4;
data = tphat(mic_range,:)' * 340

th = [
2056.2 246.1;   % 1
-2233.4 409.9;  % 2
57.8 -3419.1;   % 3
218.9 3348.3;   % 4
-2140.7 1154.6; % 5
-2105.4 -2200.3;% 6
-2210.4 -505.8; % 7
-2179.2 2157.2  % 8 
]

th = th(mic_range,:)
th = reshape(th.',1,[])

sm.th = th * 0.001
R = diag(err_std(mic_range,:))
sm.pe = ndist(zeros(4,1), R) % maybe kaos
hold on
plot(sm)
hold on
crlb(sm) % !!!!!!!!!!!!!!!!!!! använd crlb2 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% We see that config 1 is better since the crlb is better and rounder

%%
%% 7.5
%xnls = estimate(sm, data, 'thmask', ones(8,1));
amount_data_points = size(data(:,1), 1)
amount_states = size(sm.x0, 1)
r0 = mean(data(1,:));

res = zeros(amount_states, amount_data_points);
sm.x0 = [0 0 r0];
xls = ls(sm, sig(data));
for i=1:length(data(:,1))
    %xwls = wls(sm, sig(data(i,:)));
    xls2 = wls(sm, sig(data(i,:)));
    
    %xplot2(xls, 'conf', 90);
    sm.x0 = [xls2.x(1:2) sm.x0(3) + 0.5];
    xls.x(i,:) = xls2.x;
end
hold on
xplot2(xls, 'conf', 90);


%xplot2(xnls, 'conf', 90);
%% 7.6





%%