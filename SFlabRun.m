%% Load recorded data (both audio recording and positional recordings).
% Make sure to add the data directory to the path
filename = 'RealG3';
[data, fs] = audioread(sprintf("%s.wav", filename));
load(sprintf("%s.mat", filename));
%% Setup
% Channels to detect pulses in
channels = 1:8;
% Number of pulses per second
npt = 2;
% Plot during processing
plot_on = 1;
% Type of pulse - chirp or ofdm
type = 'chirp';
% Minimal prominence of detected peaks, tuneable
min_prominence = 0.0;
%% Detect pulse times and indices
tphat = SFlabFindPulseTimes(data, channels, fs, ...
                                    npt, plot_on, type, min_prominence);
%% Microphone locations (find in Qualisys -- in m)
mic_locations = []';
x0 = position(1, 2:end);
position = position'; % Transpose position as ROS saves as N x M
%% Plot normalized detected times
% Assumes a pulse is present at time 0
tmp = fix(median(tphat, 1));
dtmp = diff(tmp)*0.5;
if tmp(end) == tmp(end-1)
    tmp = tmp + [dtmp, 0.5];
else
    tmp = tmp + [dtmp, 0];
end
figure(200);
plot((tphat-tmp)');
title('Normalized time of detected pulses');
xlabel('Time index');
ylabel('Normalized time');
%% Check maximal differences in calibration dataset (may also be used for runs)
maxerr = @(channels) (max(tphat(channels, :), [], 1)-min(tphat(channels, :), [], 1))*343;
fprintf("***\tMaximal Differences\t***\n\tMean: %d\n\tStd:  %d\n", mean(maxerr(1:4)), std(maxerr(1:4)))
%% Save data
save dataset.mat fs tphat position mic_locations x0