function [x, P] = mu_m(x, P, ymag , Rm, m0)


[dq1, dq2, dq3, dq4] = dQqdq(x);

h_dx = [dq1*m0, dq2*m0, dq3*m0, dq4*m0];

S = Rm + h_dx*P*h_dx';
K = P*h_dx'*inv(S);

eps = ymag - Qq(x)*m0;

x = x + K * eps;
P = P - P*h_dx'*inv(S)*h_dx*P;
x = qnorm(x);


end