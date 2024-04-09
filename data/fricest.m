function fricest

%Friction estimation based on measurements of wheel slip and traction force
%
% Data for friction estimation. The measurement y consists of wheel slip
% measurements, which is a linear function of normalized wheel torque u.
% Wheel slip is defined as the relative speed difference of a driven wheel's
% circumferential speed and its absolute speed, which is in the order of 0.001.
% The normalized traction force is the engine torque, compensated with gearing
% ratio and normal force at the driven wheel.
%
% A suitable model is a linear regression with y=th1*u+th2
% The value 1/th1 corresponds to the longitudinal stiffness that varies
% with friction, while the constant th2 relates to the tire radii of the wheels
% used to compute the slip.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $


help fricest
load fricest
subplot(2,1,1), 
plot(y.t,y.y)
title('Slip')
subplot(2,1,2), 
plot(y.u(:,1))         % Only input
title('Normalized traction force')


thhat=y.u\y.y;
figure
plot(y.y,y.u(:,1),'.')
hold on
plot([0 1;0.3 1]*thhat,[0 0.3],'r','linewidth',3)
title(['Slope = ',num2str(round(1/thhat(1)))])
