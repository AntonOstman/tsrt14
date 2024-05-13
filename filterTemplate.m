function [xhat, meas] = filterTemplate(fname, calAcc, calGyr, calMag)
% FILTERTEMPLATE  Filter template
%
% This is a template function for how to collect and filter data
% sent from a smartphone live. As you implement your own orientation 
% estimate, it will be visualized in a simple illustration. If the 
% orientation estimate is checked in the Sensor Fusion app, it will be 
% displayed in a separate view.
% 
% [xhat, meas] = FILTERTEMPLATE() starts a server that the Sensor Fusion
% app can connect to and runs the implemented filter. Interrupting the code
% yields the result in xhat and meas.
%
% [xhat, meas] = FILTERTEMPLATE(fname) uses the data in fname as the
% measurement source instead of a stream. The function returns when the
% data file has been completely parsed.
%
% Input
% ------
% fname: string
%       Path to data file
% 
% calAcc/calGyr/calMag: struct with fields:
%       m: bias mean
%       R: bias covariance
%
% Output
% ------
% xhat: struct with fields:
%       t: timestamp (1 x T)
%       x: state estimate for corresponding timestamp (nx x T)
%       P: state covariance for corresponding timestamp (nx x nx x T)
% 
% meas: struct with fields:
%       t: timestamp (1 x T)
%       acc: accelerometer measurement for corresponding timestamp (3 x T)
%       gyr: gyroscope measurement for corresponding timestamp (3 x T)
%       mag: magnetometer measurement for corresponding timestamp (3 x T)
%       orient: orientation quaternion from the phone for corresponding 
%               timestamp (4 x T)
%
% Measurements not available are marked with NaNs.

  %% Setup necessary infrastructure
  import('se.hendeby.sensordata.*');  % Used to receive data.

  DISPLAY_FREQ = 10; % [Hz]  Frequency of update of the visualization

  %% Filter settings
  t0 = [];  % Initial time (initialize on first data received)
  nx = 4;
  % Add your filter settings here.

  % Current filter state.
  x = [1; 0; 0; 0];
  P = eye(nx, nx);

  % Saved filter states.
  xhat = struct('t', zeros(1, 0),...
                'x', zeros(nx, 0),...
                'P', zeros(nx, nx, 0));

  meas = struct('t', zeros(1, 0),...
                'acc', zeros(3, 0),...
                'gyr', zeros(3, 0),...
                'mag', zeros(3, 0),...
                'orient', zeros(4, 0));
  try
    %% Create data link
    err_hint = ['Unsuccessful loading of sensordata.jar!\n',...
        'Make sure to run startup.m before attempting to run this function.'];
    if nargin == 0 || isempty(fname)
      server = StreamSensorDataReader(3400);
      err_hint = ['Unsuccessful connecting to client!\n',...
        'Make sure to start streaming from the phone *after* starting this function.'];
    else
      server = FileSensorDataReader(fname);
      err_hint = sprintf(['Unsuccessful reading data from file!\n',...
        'Make sure ''%s'' is the correct path to the log file.'], fname);
    end
    % Makes sure to resources are returned.
    sentinel = onCleanup(@() server.stop());

    server.start();  % Start data reception.
    clear err_hint
  catch e
    e = e.addCause(MException(sprintf('%s:UnableToConnect', mfilename), err_hint));
    rethrow(e);
  end

  % Used for visualization.
  figure(1);
  subplot(1, 2, 1);
  ownView = OrientationView('Own filter', gca);  % Used for visualization.
  ownView.activateKeyboardCallback;
  googleView = [];
  tnextdisp = 0;  % Next time to update the visualization

  %% Filter loop
  % Repeat while data is available and q hasn't been pressed
  while server.status() && ~ownView.quit
    % Get the next measurement set, assume all measurements
    % within the next 5 ms are concurrent (suitable for sampling
    % in 100Hz).
    data = server.getNext(5);

    if isnan(data(1))  % No new data received
      continue;
    end
    t = data(1)/1000;  % Extract current time

    if isempty(t0)  % Initialize t0
      t0 = t;
    end

    gyr = data(1, 5:7)';
    if ~any(isnan(gyr))  % Gyro measurements are available.
      % Do something
    end

    acc = data(1, 2:4)';
    if ~any(isnan(acc))  % Acc measurements are available.
      % Do something
    end

    mag = data(1, 8:10)';
    if ~any(isnan(mag))  % Mag measurements are available.
      % Do something
    end

    orientation = data(1, 18:21)';  % Google's orientation estimate.

    % Visualize result
    if t >= tnextdisp
      tnextdisp = t + 1/DISPLAY_FREQ;  % Next vizualization update
      setOrientation(ownView, x(1:4));
      title(ownView, 'OWN', 'FontSize', 16);
      if ~any(isnan(orientation))
        if isempty(googleView)
          subplot(1, 2, 2);
          % Used for visualization.
          googleView = OrientationView('Google filter', gca);
        end
        setOrientation(googleView, orientation);
        title(googleView, 'GOOGLE', 'FontSize', 16);
      end
    end

    % Save estimates
    xhat.x(:, end+1) = x;
    xhat.P(:, :, end+1) = P;
    xhat.t(end+1) = t - t0;

    meas.t(end+1) = t - t0;
    meas.acc(:, end+1) = acc;
    meas.gyr(:, end+1) = gyr;
    meas.mag(:, end+1) = mag;
    meas.orient(:, end+1) = orientation;
  end
end
