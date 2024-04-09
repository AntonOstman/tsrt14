% 
%  Finds a number of local maxima in a signal with a minimal distance to 
%  one another.
% 
%  function [max_indices] = find_local_maxima(data, n_pulse, minDist)
% 
%  INPUTS:
%  data              -  NxM-matrix with sound data, where M=length(mics) and
%                       N = (sampRate)*(time). Each column contains data from
%                       one of the microphones.
%  n_max             -  Number of maxima to find.
%  min_dist          -  Minimal distance (indices) between maxima.
%  min_prominence    -  Minimal prominence of local maxima. Data is first
%                       normalized, i.e., prominence is [0, 1]. Default 0.1.
% 
%  OUTPUTS:
%  max_indices  -  Matrix with index of local maxima.
% 
% 
%  Anton Kullberg 
%  2023-03-06
%  Adapted from
%  Martin Skoglund and Karl Granström
%  2009-03-24
%