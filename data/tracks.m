function tracks

%TRACKS Benchmark trajectories for aircraft in 3D
% x=[X,Y,Z,vX,vY,vZ,aX,aY,aZ]
% y=x
%

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $


help tracks
load tracks

for k=1:6
	disp(['y',num2str(k),': ',eval(['y',num2str(k),'.name'])])
end
figure
subplot(3,2,1)
xplot2(y1)
subplot(3,2,2)
xplot2(y2)
subplot(3,2,3)
xplot2(y3)
subplot(3,2,4)
xplot2(y4)
subplot(3,2,5)
xplot2(y5)
subplot(3,2,6)
xplot2(y6)
