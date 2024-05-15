function [x, P] = mu_g(x, P, yacc, Ra, g0)

[dq1, dq2, dq3, dq4] = dQqdq(x);

h_dx = [dq1*g0, dq2*g0, dq3*g0, dq4*g0];

S = Ra + h_dx*P*h_dx';
K = P*h_dx'*inv(S);

eps = yacc - Qq(x)*g0;

x = x + K * eps;
P = P - P*h_dx'*inv(S)*h_dx*P;
x = qnorm(x);



end