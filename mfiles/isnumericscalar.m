function ok=isnumericscalar(x)
%ISNUMERICSCALAR tests if the argument is numeric and scalar
%
% ok=isnumscalar(x)

% Copyright Fredrik Gustafsson
%$ Revision: v2023.4 $

ok = isnumeric(x) && isscalar(x);
