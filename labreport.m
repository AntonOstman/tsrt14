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
%
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
%
% * _What has gyroscope measurements added?_
% * _What is the difference between starting the program with the phone flat
%   on the desk and in a random pose?  Why?_

%% 4. Add the EKF accelerometer measurement update step
% _*Include your accelerometer measurement update function* from the
% preparations here:_
%
% <include>mu_g.m</include>
%
%%
% _*Motivate parameter choices:*_
%
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
% * _What happens when you shake or quickly slide the phone on a surface?
%   Why?_
%

%% 5. Add accelerometer outlier rejection
% _*Describe your accelerometer outlier rejection:*_
%
% * _What is considered an outlier?_
% * _What do you do when you encounter an outlier?_
%
%%
% _*How did you implement the outlier rejection?*_
%%
%
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
%
% * _What happens when you shake or quickly slide the phone on surface?
%   Why?_

%% 6. Add the EKF magnetometer measurement update step
% _*Include your magnetometer measurement update function* from the
% preparations here:_
%
% <include>mu_m.m</include>
%
%%
% _*Motivate parameter choices:*_
%
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
% * _What happens when you put the phone close to a magnet?  (Use a
%   refridgerator magnet, or hold the phone close to, eg, the keyboard
%   which is usually magnetic.)  Why?_

%% 7. Add magnetometer outlier rejection
% _*Describe your magnetometer outlier rejection:*_
%
% * _What is considered an outlier?_
% * _What do you do when you encounter an outlier?_
%
%%
% _*How did you implement the outlier rejection?*_
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
figure
visDiff(xhat8, meas8);
%%
% _*Shortly describe your observations:*_
%
% * _How does the behavor differ when using and not the gyroscope?_
% * _Some phones has no gyroscope, to reduce the production cost and
%   preserve battery.  How does that affect their ability to estimate
%   orientation?_

%% 9. If you are interested and have time
% _No need to report back if you did this, but feel free if you did._

%% APPENDIX: Main loop
%
% <include>ekfFilter.m</include>
%
