function [x, P] = tu_qw(x, P, omega, T, Rw)
% The update step i given by 197 in book
I = eye(4);

%if nargin == 4
%    P = T^2/4 * Sq(x) * Rw * Sq(x)' + (I + Sq(x)*omega*T) * P * (Sq(x) * omega*T)' % 8.3f book dq=dh
%    x=x
%else   
    x = (I + 1/2 * Somega(omega) * T) * x; % 6b lab pm, TT1 gives no process noise added here
    % Noise given by G *w *G' and G is from T/2Somega * wk so G = T/2 Somega
    if any(isnan(T)) || any(isnan(omega))
        disp('NANANANANANANANANANANAN')
    end
    P = T^2/4 * Sq(x) * Rw * Sq(x)' + (I + 1/2 * Sq(x)*omega*T) * P * (I + 1/2 * Sq(x) * omega*T)'; % 8.3f book dq=dh
%end
    x = qnorm(x);
end