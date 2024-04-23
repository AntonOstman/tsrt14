


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
tdoa_errors = zeros(12,25)
errors = zeros(8,24);

for i = 1:size(tphat,2) - 1
    errors(:,i) = tphat(:,i + 1) - tphat(:,i);
end

tdoa_errors(1,:) = tphat(1,:) - tphat(2,:);
tdoa_errors(2,:) = tphat(1,:) - tphat(3,:);
tdoa_errors(3,:) = tphat(1,:) - tphat(4,:);
tdoa_errors(4,:) = tphat(2,:) - tphat(3,:);
tdoa_errors(5,:) = tphat(2,:) - tphat(4,:);
tdoa_errors(6,:) = tphat(3,:) - tphat(4,:);

tdoa_errors(7,:) = tphat (5,:) - tphat(6,:);
tdoa_errors(8,:) = tphat (5,:) - tphat(7,:);
tdoa_errors(9,:) = tphat (5,:) - tphat(8,:);
tdoa_errors(10,:) = tphat(6,:) - tphat(7,:);
tdoa_errors(11,:) = tphat(6,:) - tphat(8,:);
tdoa_errors(12,:) = tphat(7,:) - tphat(8,:);

chirp_interval = 0.5;
errors = errors - chirp_interval;
sel_err = errors;
err_mean = mean(sel_err, 2);
err_std = std(sel_err, 0, 2);

err_tdoa_std = std(tdoa_errors,0,2);

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

%sm = exsensor('tdoa1', 4,1)
sm = sensormod(@model1, [3 0 4 8])
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

sm = exsensor('tdoa2',4,1)
sm.th = th * 0.001
R = diag(err_tdoa_std(1:6,:));
sm.pe = ndist(zeros(6,1), R) % maybe kaos
%xnls = estimate(sm, data, 'thmask', ones(8,1));

sm.x0 = [0 0];
data1 = data(:,1) - data(:,2);
data2 = data(:,1) - data(:,3);
data3 = data(:,1) - data(:,4);
data4 = data(:,2) - data(:,3);
data5 = data(:,2) - data(:,4);
data6 = data(:,3) - data(:,4);
data_new = [data1, data2, data3, data4, data5, data6];

for i=1:length(data_new(:,1))
    [xhat, shat] = wls(sm, sig(data_new(i,:)));
    plot(shat,'conf',90)
    sm.x0 = [shat.x0(1:2) ];

end
hold on
%xplot2(xls, 'conf', 90);

%% 7.5 b)
sm = sensormod(@model1, [3 0 4 8])
sm.th = th * 0.001
R = diag(err_std(mic_range,:))
sm.pe = ndist(zeros(4,1), R) % maybe kaos
hold on 
plot(sm)
hold on
crlb(sm) % !!!!!!!!!!!!!!!!!!! använd crlb2 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

r0 = mean(data(1,:));
sm.x0 = [0 0 r0];
data_points = zeros(179,3)
for i=1:length(data(:,1))
    [shat, xhat] = nls(sm, sig(data(i,:)), 'thmask', zeros(sm.nn(4), 1));
    sm.x0 = [shat.x0(1:2)' shat.x0(3) + 0.5];
    data_points(i,:) = xhat.sol;
    plot(shat,'col','r', 'conf',90);
end

hold on
%%

%xplot2(xnls, 'conf', 90);
%% 7.6

direct_measurement = @(t,x,u,th) [x(1,:); x(2,:)];
sm = sensormod(direct_measurement, [2 0 2 0]);

m = exmotion('cv2d');
m = m.addsensor(sm);
m.pe=eye(2) * 0.1;
xhat1 = ekf(m, sig(data_points(:, 1:2))); % Time - varying
xplot2(xhat1, [1 2]);
hold on

sm = sensormod(direct_measurement, [2 0 2 0]);
m = exmotion('ca2d');
m = m.addsensor(sm);
m.pe=eye(2) * 0.1;
xhat1 = ekf(m, sig(data_points(:, 1:2))); % Time - varying
xplot2(xhat1, [1 2],'col','yellow');

%%

%% 7.6 b)
TDOA_measurements = data(:, 4) - data(:, 1:3);
sm = sensormod(@model2, [2 0 3 8]);

%R = diag(err_std(mic_range,:)); % 4 har lowest covariance choose that
R = diag(err_tdoa_std(1:3));
mm = exmotion('cv2d', 0.5);
mms = addsensor(mm, sm);
mms.pe = ndist(zeros(3,1), R(1:3,1:3)); % maybe kaos
mms.pv = mms.pv
mms.th = th * 0.001;
mms.x0 = [0, 0, -0.839, -0.2092];
%mms.pe=sm.pe
xhat1 = ekf(mms, sig(TDOA_measurements)); % Time - varying

xplot2(xhat1)
%%
