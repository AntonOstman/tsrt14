%  SFlabFindPulseTimes Finds times of a known pulse in a audio recording.
% 
%  function pulse_times = SFlabFindPulseTimes(data,channels,...
%      sampRate,npt,plot_on,type,ignore_polarity)
% 
%  INPUTS:
%  data            -  NxM-matrix with sound data, where M=length(mics) and
%                     N = (sampRate)*(time). Each column contains data from
%                     one of the microphones.
%  channels        -  What channels to detect signal in.
%  samp_rate       -  Sampling frequency.
%  npt             -  Number of pulses per second.
%  plot_on         -  Plot option, set 1 to plot, 0 otherwise.
%  type            -  "ofdm" or "chirp"
%  min_prominence  -  Minimal normalized prominence to be considered a
%                     detection [0, 1]. Default: 0.02 \approx 1/6^2
%  ignore_polarity -  If polarity should be ignored when detecting pulses or
%                     not.  Default: true
% 
%  OUTPUTS:
%  pulse_times     -  Matrix with pulse times, element (m,:) contains the
%                     pulse times for microphone m.
% 
%  Anton Kullberg 
%  2023-04-12
%  Adapted from
%  Martin Skoglund and Karl Granström
%  2009-03-24
%