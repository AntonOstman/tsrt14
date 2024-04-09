function robot

%ROBOT Accelerometer and gyroscope measurements on robot at stand still

% Data useful for examining sensor characteristics and disturbances
% There is one characteristic 30 Hz vibration mode visible, see fig 2

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

load robot


figure(1)
plot(yacc)
figure(2)
plot(ft(yacc(:,1:2)),'Xlim',[-100 100],'Ylim',[0 30])

figure(3)
for i=1:3
   Y=empdist(yacc(:,i));
   subplot(3,1,i)
   plot(Y,estimate(ndist,Y))
%   title(yacc.ylabel{i})
end
figure(4)
Y12=empdist(yacc(:,1:2));
Y12hat=estimate(ndist,Y12);
plot2(Y12hat,Y12,'legend','')
hold off
axis([-0.05 0.035 -0.27 -0.2])
