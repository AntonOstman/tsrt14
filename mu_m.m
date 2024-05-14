function [x, P] = mu_m(x, P, ymag , Rm, m0)


h_dx = dQqdq(x)*m0;

S = Rm + h_dx*P*h_dx';
K = P*h_dx*inv(S);

eps = ymag - Qq(x)*m0;

x = x + K * eps;
P = P - P*h_dx'*inv(S)*h_dx*P;

end