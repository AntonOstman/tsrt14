function [x, P] = mu_g(x, P, yacc, Ra, g0)

h_dx = dQqdq(x)*g0;

S = Ra + h_dx*P*h_dx';
K = P*h_dx*inv(S);

eps = yacc - Qq(x)*m0;

x = x + K * eps;
P = P - P*h_dx'*inv(S)*h_dx*P;



end