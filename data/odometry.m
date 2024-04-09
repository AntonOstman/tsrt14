function odometry

%ODOMETRY Wheel speeds from a car with GPS reference data
%
% Car: Audi A6 (AWD)
% B = 2.84  wheel base 
% Lf = 1.51, front wheel axle length
% Lr = 1.62, rear wheel axle length
% R0= 0.31 nominal wheel radius
% Format on Data:
%  t       = Data(:,1);    % Time [s]
%  w       = Data(:,2:5);  % w_FL, w_FR, w_RL, w_RR [km/h]
%  GPSlong = Data(:,6);    % deg
%  GPSlat  = Data(:,7);    % deg
%
% SIG objects:
% y1  wheel speeds and GPS position as outputs y
% y2  speed and yaw rate as inputs, GPS position as output
%
% Data provided by Rickard Karlsson at NIRA Dynamics
% used to compute the slip.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $


help odometry
load odometry
im=imread('odometry.jpg');
figure(1) 
X=1e7/90*cos(pi/180*Data(:,7)).*(Data(:,6)-Data(1,6));
Y=1e7/90*(Data(:,7)-Data(1,7));
image(im)
X0=157;
Y0=380;
figure(2) 
plot(X,Y,'-.')
xlabel('X [m]')
ylabel('Y [m]')
figure(3)
plot(Data(:,1),Data(:,2:5)/0.31/2/pi/3.6,'-.')
xlabel('Time')
ylabel('Angular speeds [rad/s]')
legend('w_{FL}','w_{FR}','w_{RL}','w_{RR}')

format long
long=Data(1,6)
lat=Data(1,7)
format short
figure(4)
Lr = 1.62; %rear wheel axle length
R0= 0.3;  % nominal wheel radius
% odometry
t1=Data(1:end,1);
fs1=100;
v1=0.5*R0*sum(Data(:,4:5),2);
psi1=1/fs1*cumsum(v1.*R0/Lr.*diff(Data(:,4:5),1,2));
% GPS
t2=Data(100:100:end,1);
fs2=1;
v2=0.15*sqrt(diff(X(1:100:end)).^2+diff(Y(1:100:end)).^2);
psi2=unwrap(atan2(diff(Y(1:100:end)),diff(X(1:100:end))));

subplot(2,1,1)
plot(t1,v1,'-b',t2,v2,'--g')
legend('Odometry','GPS')
ylabel('v_x')
subplot(2,1,2)
plot(t1,psi1,'-b',t2,psi2,'--g')
legend('Odometry','GPS')
ylabel('\Psi')
xlabel('Time [s]')


B = 2.84   %wheel base 
Lf = 1.51, %front wheel axle length
Lr = 1.62, %rear wheel axle length
R0= 0.3;  % nominal wheel radius
th=[R0 B Lf Lr]';
thlabel={'R0','B','Lf','Lr'};

fs=100;
y1=sig(Data(:,2:7),fs);
y1.ylabel={'w_FL','w_FR','w_RL','w_RR','long','lat'}
y1.desc='Odometry data: wheel speeds and GPS position';

y2=sig([X Y],fs1,[v1 psi1]);
y2.ulabel={'v [m/s]','\dot{psi} [rad/s]'}
y2.thlabel={'R0','B','Lf','Lr'};
y2.desc=['Odometry data: speed and yaw rate as inputs, GPS position ' ...
         'as output'];

save odometry Data y1 y2 th thlabel
