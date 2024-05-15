%% TSRT14, Lab 2: Orientation
% _This lab report describes the experiences made while working with lab 2
% in TSRT14 Sensor Fusion._
%
%% *Group members:*
%
% # NN1 (YYMMDD-NNNN), LiU-ID
% # NN2 (YYMMDD-NNNN), LiU-ID
%
%% _Usage_
% _This file is intended to be a template for reporting the results on lab
% 2. Use the function names as indicated in the preparatory lab work (these
% are included at appropriate places), and copy filterTempate.m into
% ekfFilter.m before starting to make your changes (it will be included at
% the end of the report for reference)._
%
% _There is no need to be talkative when answering the questions, assume
% that the person reading the report has read the lab instructions. The
% purpose is to show that you have been able to observe and experience the
% important aspects of the lab and do not miss out on anything important._
%
% _Use the different cells in this file to collect data for the plots you
% are asked for in each steps of the lab. Running the cells interactively
% will collect a dataset, which is then saved in |DATAFILE.mat|. The
% collection of datasets are then extracted when publishing this file,
% to make a report you can hand in._
%
% _Before publishing, remove any and all text in italic (lines starting and
% ending with an underscore (_)) to minimize the report length. Make sure to
% publish to pdf._

if inpublish  % Load saved data when publishing.
  load DATAFILE
end


%% 1. Connect the phone with your lab computer
% *No need to document this step.*

%% 2. Get to know your data
% *Shortly describe your observations?*

if ~inpublish  % Don't recollect data during publish
  [xhat2, meas2] = ekfFilter();
  save DATAFILE -append xhat2 meas2
end
%%

% _Put your code to visualize the data here_

load xhat.mat
load meas.mat

mean(meas.acc(:, ~any(isnan(meas.acc), 1)), 2)

Ts = 0.01;
cutoff = 4/Ts;

meas.t = meas.t(:,1:cutoff);
meas.gyr = meas.gyr(:,1:cutoff);
meas.acc = meas.acc(:,1:cutoff);
meas.orient = meas.orient(:,1:cutoff);
meas.mag = meas.mag(:,1:cutoff);

xhat.t = xhat.t(:,1:cutoff);
xhat.x = xhat.x(:,1:cutoff);
xhat.P = xhat.P(:,:,1:cutoff);


figure(1)
subplot(3,1,1)
plot(meas.t, meas.acc)
subplot(3,1,2)
plot(meas.t, meas.gyr)
subplot(3,1,3)
plot(meas.t, meas.mag)



figure(2)
subplot(3,3,1)
hist(meas.acc(1,:))
subplot(3,3,2)
hist(meas.acc(2,:))
subplot(3,3,3)
hist(meas.acc(3,:))

subplot(3,3,4)
hist(meas.gyr(1,:))
subplot(3,3,5)
hist(meas.gyr(2,:))
subplot(3,3,6)
hist(meas.gyr(3,:))

subplot(3,3,7)
hist(meas.mag(1,:))
subplot(3,3,8)
hist(meas.mag(2,:))
subplot(3,3,9)
hist(meas.mag(3,:))

calGyr.m = mean(meas.gyr(:, ~any(isnan(meas.gyr), 1)), 2);
calMag.m = mean(meas.mag(:, ~any(isnan(meas.mag), 1)), 2);
calAcc.m = mean(meas.acc(:, ~any(isnan(meas.acc), 1)), 2);

calGyr.R = diag(std(meas.acc(:, ~any(isnan(meas.acc), 1)),0, 2));
calMag.R = diag(std(meas.mag(:, ~any(isnan(meas.mag), 1)),0, 2));
calAcc.R = diag(std(meas.gyr(:, ~any(isnan(meas.gyr), 1)),0, 2));



%{
AVERAGES
mean(meas.acc(:, ~any(isnan(meas.acc), 1)), 2)
ans =
    0.0085
    0.1544
    9.8807
mean(meas.gyr(:, ~any(isnan(meas.gyr), 1)), 2)
ans =
   1.0e-03 *

   -0.5136
   -0.0326
    0.4701

mean(meas.mag(:, ~any(isnan(meas.mag), 1)), 2)
ans =
  -37.6784
  -21.6402
  -39.9535

STANDARD DEVIATIONS

std(meas.acc(:, ~any(isnan(meas.acc), 1)),0, 2)

ans =

    0.0217
    0.0332
    0.0144

std(meas.mag(:, ~any(isnan(meas.mag), 1)),0, 2)

ans =

    0.5320
    0.4313
    0.3144

std(meas.gyr(:, ~any(isnan(meas.gyr), 1)),0, 2)

ans =

    0.0009
    0.0015
    0.0010
%}










%%
% *Result*
%
% * _A histogram of the measurements for each sensor and axis._
% * _A plot of the signals over time. If there are trends figure out a way
% to deal with these._
% * _The determined average acceleration vector, angular velocity vector,
% and magnetic field, and their respective covariance matrices._

%% 3. Add the EKF time update step
% _*Include your time update function* from the
% preparations here:_
%
% _For simplicity, use the same function for the case with and without gyro
% support and differentiate the two, eg, by checking for empty gyro input._
%
% <include>tu_qw.m</include>
%
%%
% _*Motivate parameter choices:*_
% Gyro is very reactive so it gets a very high scaling
%%
% *Result*
%
% _Run the indicated code below to generate results to plot._
if ~inpublish  % Don't recollect data during publish
  [xhat3, meas3] = ekfFilter();
  save DATAFILE -append xhat3 meas3
end
%%
figure
visDiff(xhat3, meas3);
%%
% *_Shortly describe your observations:_*
% We see that it is okay the the start if it is in the correct starting
% position, however it collects much drift
% * _What has gyroscope measurements added?_
% Relative orientation from start
% * _What is the difference between starting the program with the phone flat
%   on the desk and in a random pose?  Why?_
% Orientation is relative so if it dont start flat we dont start in the
% correct posistion

%% 4. Add the EKF accelerometer measurement update step
% _*Include your accelerometer measurement update function* from the
% preparations here:_
%
% <include>mu_g.m</include>
%
%%
% _*Motivate parameter choices:*_
% Acceleromter is usally good so it does not have too high of scaling
%%
% *Result*
%
% _Run the indicated code below to generate results to plot._
if ~inpublish  % Don't recollect data during publish
  [xhat4, meas4] = ekfFilter();
  save DATAFILE -append xhat4 meas4
end
%%
figure
visDiff(xhat4, meas4);
%%
% _*Shortly describe your observations:*_
%   
% * _What has the accelerometer added?_
% It has added some sort of absolute positioning, the phone knows what down
% is
% * _What happens when you shake or quickly slide the phone on a surface?
%   Why?_
% it belevies it is flipping in may directions, likely because magnitude of 
% the axis on the accelerometer are quickly turning
%

%% 5. Add accelerometer outlier rejection
% _*Describe your accelerometer outlier rejection:*_
% we check if the norm is within 8.5 to 9.5
% * _What is considered an outlier?_
% * _What do you do when you encounter an outlier?_
% When hard forces are turning the phone
%%
% _*How did you implement the outlier rejection?*_
%%
%        if (norm(acc,2) < 10.5 && norm(acc,2) > 8.5)
%            [x, P] = tu_qw(x, P, gyr - calGyr.m, T, calGyr.R);
%            setAccDist(ownView, 0)
%        else
%            setAccDist(ownView, 1)
%        end
%   % _Write code to clarify here._
%
%%
% *Result*
%
% _Run the indicated code below to generate results to plot._
if ~inpublish  % Don't recollect data during publish
  [xhat5, meas5] = ekfFilter();
  save DATAFILE -append xhat5 meas5
end
%%
figure
visDiff(xhat5, meas5);
%%
% _*Shortly describe your observations:*_
% It is better at finding the facing direction
% * _What happens when you shake or quickly slide the phone on surface?
%   Why?_
% It is way less violently shaking than before, the magnitude is not
% allowed to accumulate as much
%% 6. Add the EKF magnetometer measurement update step
% _*Include your magnetometer measurement update function* from the
% preparations here:_
%
% <include>mu_m.m</include>
%
%%
% _*Motivate parameter choices:*_
% Same as accelerometer
%
%%
% *Result*
%
% _Run the indicated code below to generate results to plot._
if ~inpublish  % Don't recollect data during publish
  [xhat6, meas6] = ekfFilter();
  save DATAFILE -append xhat6 meas6
end
%%
figure
visDiff(xhat6, meas6);
%%
% _*Shortly describe your observations:*_
%
% * _What has the magnetometer added?_
% It has added a compas like effect, so the phone should know when it is
% oriented east west etc,
% * _What happens when you put the phone close to a magnet?  (Use a
%   refridgerator magnet, or hold the phone close to, eg, the keyboard
%   which is usually magnetic.)  Why?_
% it uses this to orient itself since the magnet is stronger than magnetic
% field or world

%% 7. Add magnetometer outlier rejection
% _*Describe your magnetometer outlier rejection:*_
%
% * _What is considered an outlier?_
% * _What do you do when you encounter an outlier?_
%
%%
% _*How did you implement the outlier rejection?*_
% if the absolute value from calibration is more than 20mT
%%
%
%   % _Write code to clarify here._
%
%%
% *Result*
%
% _Run the indicated code below to generate results to plot.  Save the
% resulting matrices in a mat-file, just in case you have to restart matlab
% before compiling the report._
if ~inpublish  % Don't recollect data during publish
  [xhat7, meas7] = ekfFilter();
  save DATAFILE -append xhat7 meas7
end
%%
figure
visDiff(xhat7, meas7);
%%
% _*Shortly describe your observations:*_
%
% * _What happens when you put the phone close to a magnet?  Why?_
% The measurements starts to get rejected since the magnitud difference
% from calibarion is to large

%% 8. Test your filter without gyroscope measurements
% _The easiest way to do this is to run your full filter implementation and
% switch gyro measurements on and off in the app._
%
%%
% *Result*
%
% _Run the indicated code below to generate results to plot._
if ~inpublish  % Don't recollect data during publish
  [xhat8, meas8] = ekfFilter();
  save DATAFILE -append xhat8 meas8
end
%%
figure
visDiff(xhat8, meas8);
%%
% _*Shortly describe your observations:*_
%
% * _How does the behavor differ when using and not the gyroscope?_
%  It still works but is less precise when it comes to quick turns
% * _Some phones has no gyroscope, to reduce the production cost and
%   preserve battery.  How does that affect their ability to estimate
%   orientation?_
% Makes it worse, and if there are disturbences to magnetometer it could 
% become h to hard, but will likely mostly still work okay
% Quick movements will be difficult

%% 9. If you are interested and have time
% _No need to report back if you did this, but feel free if you did._

%% APPENDIX: Main loop
%
% <include>ekfFilter.m</include>
%
