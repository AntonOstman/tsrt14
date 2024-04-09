function wheelspeed

%WHEELSPEED Measurements from ABS sensor for rear left and right wheels
%
%  The raw data are cog stamps for each 2*pi/48 rad angle displacement.
%  Cog data converted to angular frequencies in y
%  Irregular sampling resampled to 500 Hz for rear right wheel,
%  which for synchronization issues corresponds to 515 Hz on rear left wheel.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help wheelspeed
close all
load wheelspeed

figure
plot(y1,y2)
figure
omega=(0:length(y2.y)-1)/length(y2.y)*500;
nf=60;
plot(omega,filtfilt(ones(1,nf),1,abs(fft(y2.y)))/nf^2)
axis([20 100 0 500])

return
N=length(y2.y);
%omega=(0:length(w2)-1)/length(w2)*500;
plot(ft(y2,'Nf',N))
