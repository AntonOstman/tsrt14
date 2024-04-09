function genera

%GENERA Number of genera over time (million years)
%
% The data show how the number of genera evolves over time 
% in million years. This number is estimated by counting 
% number of fossils in terms of geologic periods, epochs, 
% states and so on. These layers of the stratigraphic column
% have to be assigned dates and durations in calendar years, 
% which is here done by resampling techniques.
%
% y1       uniformly resampled data 
% y2       original non-uniformly sampled data
%
% See Brian Hayes, "Life cycles", American Scientist, 
%     July-August, 2005, p299-303.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help genera
load genera

figure(1), 
[yd,trend,lsfit]=detrend(y1,3);
sigplot(y1,yd,trend)
set(gca,'Ylim',[-1000 5000])
leg={'Raw data','Detrended data','Cubic trend'};
legend(leg,'Location','northwest')

figure(2)
Y=ft(yd);
plot(Y,'Xlim',[0 0.03])
xlabel('Frequency [1/million years]')
[Ym,ind]=locmax(abs(Y.Y(1:100)));
T=1./Y.f(ind(1:2));
title(['Dominating period times are ',num2str(round(T(1))),' and ',num2str(round(T(2))),' million of years'])
