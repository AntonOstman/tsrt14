


%% ground tourht
clear
load("RealG3.mat")
gt = position;
plot(gt(:,2),gt(:,3))

%%
%% Task 7.1 Calculate the normal distribution parameters
load("calibration_data.mat")
tdoa_errors = zeros(12,25);
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
figure()
for i=1:8
    subplot(3,3,i)
    histfit(sel_err(i,:));
    nr_sensor = sprintf('sensor %d', i);
    title(nr_sensor)
end
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

sm = sensormod(@model1, [3 0 4 8])
mic_range2 = 5:8;
mic_range = 1:4;
data = tphat(mic_range,:)' * 343

sm2 = sensormod(@model1, [3 0 4 8])

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

th2 = th(mic_range2,:);
th2 = reshape(th2.',1,[]);
th = th(mic_range,:);
th = reshape(th.',1,[]);

sm.th = th * 0.001;
sm.x0 = [0 0 0];
sm2.th = th2 * 0.001;
sm2.x0 = [0 0 0];

R = diag(err_std(mic_range,:));
R2 = diag(err_std(mic_range2,:));

sm.pe = ndist(zeros(4,1), R); % maybe kaos
sm2.pe = ndist(zeros(4,1), R2); % maybe kaos

%%
figure(13)
subplot(2,1,1)
plot(sm)
hold on 
plot(gt(:,2),gt(:,3))
title('Config 1')
subplot(2,1,2)
plot(sm2)
hold on
plot(gt(:,2),gt(:,3))

title('Config 2')
subplot(2,1,1)
hold on
%crlb(sm)
crlb2(sm, [], -1.5:.1:1.5, -2.5:.1:2.5, [1 2], 'rmse')
title('Config 1 CRLB')
subplot(2,1,2)
% crlb(sm2)
hold on
crlb2(sm2, [], -1.5:.1:1.5, -2.5:.1:2.5, [1 2], 'rmse')
title('Config 2 CRLB')
% We see that config 1 is better since the crlb is better and rounder

%%
%% 7.5
figure()
sm = sensormod(@model2, [2 0 3 8]);
sm.th = th * 0.001;
sm.x0 = [0 0];
R1 = eye(3) * err_std(1); 
R = diag(err_std(2:4));
sm.pe = ndist(zeros(3,1), R1 - R); % maybe kaos

TDOA_measurements = data(:,1) - data(:,2:4);
subplot(2,1,1)

for i=1:179
    %[xhat, shat] = wls(sm, sig(TDOA_measurements(i,:)));
    [shat, xhat] = nls(sm, sig(TDOA_measurements(i,:)), 'thmask', zeros(sm.nn(4), 1));
    hold on
    plot(shat,'conf',90)
    sm.x0 = [xhat.sol];
end
hold on
plot(gt(:,2),gt(:,3))
title('TDOA with pairwise difference')


%% 7.5 b)
sm = sensormod(@model1, [3 0 4 8]);
sm.th = th * 0.001;
R = diag(err_std(mic_range,:));
sm.pe = ndist(zeros(4,1), R);

r0 = mean(data(1,:));
sm.x0 = [0 0 r0];
data_points = zeros(179,3);
subplot(2,1,2)

for i=1:length(data(:,1))
    [shat, xhat] = nls(sm, sig(data(i,:)), 'thmask', zeros(sm.nn(4), 1));
    sm.x0 = [shat.x0(1:2)' shat.x0(3) + 0.5];
    data_points(i,:) = xhat.sol;
    plot(shat, 'conf', 90);
end
hold on
plot(gt(:,2),gt(:,3))
title('TDOA with bias state')
hold on
%%

%% 7.6
figure()
direct_measurement = @(t,x,u,th) [x(1,:); x(2,:)];
sm = sensormod(direct_measurement, [2 0 2 0]);

m = exmotion('cv2d');
m = m.addsensor(sm);
m.pe=eye(2) * 0.1;
xhat1 = ekf(m, sig(data_points(:, 1:2))); % Time - varying
subplot(2,2,1)
xplot2(xhat1, [1 2]);
hold on
plot(gt(:,2),gt(:,3))
title('EKF artificial measurements CV')

sm = sensormod(direct_measurement, [2 0 2 0]);
m = exmotion('ca2d');
m = m.addsensor(sm);
m.pe=eye(2) * 0.1;
m.pv = m.pv * 0.1;
xhat1 = ekf(m, sig(data_points(:, 1:2))); % Time - varying
subplot(2,2,2)
xplot2(xhat1, [1 2]);
hold on
plot(gt(:,2),gt(:,3))
title('EKF artificial measurements CA')

%%

%% 7.6 b)
TDOA_measurements = (data(:, 1) - data(:, 2:4));
sm = sensormod(@model2, [2 0 3 8]);

R1 = diag(err_std(1));
R = diag(err_tdoa_std(2:4));
mm = exmotion('cv2d', 0.5);
mms = addsensor(mm, sm);
mms.pe = ndist(zeros(3,1), R); % maybe kaos
mms.pv = mms.pv * 0.1;
mms.th = th * 0.001;
xhat1 = ekf(mms, sig(TDOA_measurements)); % Time - varying
subplot(2,2,3)
xplot2(xhat1)
hold on
plot(gt(:,2),gt(:,3))

title('EKF pairwise difference measure CV')

%%
TDOA_measurements = (data(:, 1) - data(:, 2:4));
sm = sensormod(@model2, [2 0 3 8]);

R = diag(err_tdoa_std(2:4));
mm = exmotion('ca2d', 0.5);
mms = addsensor(mm, sm);
mms.pe = ndist(zeros(3,1), R(1:3,1:3));
mms.pv = mms.pv * 0.1;
mms.th = th * 0.001;
xhat1 = ekf(mms, sig(TDOA_measurements));
subplot(2,2,4)
xplot2(xhat1)
hold on
plot(gt(:,2),gt(:,3))

title('EKF pairwise difference measure CA')

%% 7.7 
figure(99)
clf('reset')
noises = [0, 2,5,10,20,30,50,70,100] * 5
for i=1:9
    err = 1;
    sens_std = noises(i);
    
    th_bad = th + sens_std.*randn(8,1)';
    TDOA_measurements = (data(:, 1) - data(:, 2:4));
    sm = sensormod(@model2, [2 0 3 8]);
    R1 = eye(3) * err_std(1);
    R = diag(err_std(2:4));
    mm = exmotion('cv2d', 0.5);
    mms = addsensor(mm, sm);
    mms.pe = ndist(zeros(3,1), R1 + R);
    mms.pv = mms.pv * 0.1;
    mms.th = th_bad * 0.001;
    xhat1 = ekf(mms, sig(TDOA_measurements));
    subplot(3,3,i)
    xplot2(xhat1)
    hold on
    plot(gt(:,2),gt(:,3))
    title(sprintf('N(0,%d)',sens_std))
end

 

