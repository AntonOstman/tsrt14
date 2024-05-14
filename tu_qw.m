function [x, P] = tu_qw(x, P, omega, T, Rw);

I = eye(4)
x = (I + 1/2 * Somega(omega) * T) * x; % 6b lab TT1 gives no process noise added here
% Noise given by G *w *G and G is from T/2Somega * wk so G = T/2 Somega
P = T^2/4 * Sq(x) * Rw * Sq(x)' + (I + Sq(x)*omega*T) * P * (Sq(x) * omega*T)' % 8.3f book dq=dh


end