function [x, P] = tu_qw_no(x, P,T, Rw)
% The update step i given by 197 in book
I = eye(4);
    P = T^2/4 * Sq(x) * Rw * Sq(x)' + P; % 8.3f book dq=dh
end