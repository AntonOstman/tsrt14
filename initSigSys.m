function initSigSys(~)
% INITSIGSYS  Set appropriate paths for SigSys
%
% Set the paths needed to use Signals and Systems Toolbox.  The added paths
% contain the SigSys toolbox and some mat-files to exemplify its usage.
%
% If given an argument, remove the paths again.

% $ Revision: v2023.4 $

  cwd = fileparts(mfilename('fullpath'));
  if nargin == 0
    fprintf('Add paths for SigSys\n')
    add2path(cwd);
    add2path(fullfile(cwd, 'classes'));
    add2path(fullfile(cwd, 'mfiles'));
    add2path(fullfile(cwd, 'data'));
  else
    fprintf('Remove paths for SigSys\n')
    removepath(fullfile(cwd, 'data'));
    removepath(fullfile(cwd, 'mfiles'));
    removepath(fullfile(cwd, 'classes'));
    removepath(cwd);
  end
end

function add2path(p, doRecurse)
  if nargin<2 || ~doRecurse
    fprintf('  Add path: %s\n', p);
    addpath(p);
  else
    fprintf('  Recursively add path: %s\n', p);
    addpath(genpath(p));
  end
end

function removepath(p, doRecurse)
  if nargin<2 || ~doRecurse
    fprintf('  Remove path: %s\n', p);
    rmpath(p);
  else
    fprintf('  Recursively remove path: %s\n', p);
    rmpath(genpath(p));
  end
end
