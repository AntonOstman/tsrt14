function icecore

%ICECORE Vostok ice core data for 420,000 years
%
%  Description from http://www.ncdc.noaa.gov:
%  "In January 1998, the collaborative ice-drilling project between Russia,
%  the United States, and France at the Russian Vostok station in East
%  Antarctica yielded the deepest ice core ever recovered, reaching a
%  depth of 3,623 m (Petit et al. 1997, 1999).
%  Preliminary data indicate the Vostok ice-core record extends through
%  four climate cycles, with ice slightly older than 400 kyr
%  (Petit et al. 1997, 1999)."
%
%  Data are taken from
%  http://www.ncdc.noaa.gov/paleo/icecore/antarctica/vostok/vostok_data.html
%
%  Reference: Petit, J.R., et al., 2001,
%  Vostok Ice Core Data for 420,000 Years, IGBP PAGES/World Data Center
%  for Paleoclimatology Data Contribution Series 2001-076.
%  NOAA/NGDC Paleoclimatology Program, Boulder CO, USA.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

help icecore
load icecore
y=detrend(y2,0);
figure
loglog(spec(y));%,'Xlim',[0 6e-5])
title('Periodogram')

figure
Y=ft(y,'f',linspace(0,6e-5,100)');
plot(Y)
title('Fourer Transform of Vostok icecore data')
[Ymax,ind]=locmax(Y.Y);
hold on
plot(Y.f(ind(1:2)),abs(Y.Y(ind(1:2))),'ro','markersize',12,'linewidth',2)
hold off
disp(['Maximum at f = ',num2str(Y.f(ind(1)))])
text(Y.f(ind(1)),abs(Y.Y(ind(1))),['   f = ',num2str(Y.f(ind(1)))],'linewidth',2)
text(Y.f(ind(2)),abs(Y.Y(ind(2))),['   f = ',num2str(Y.f(ind(2)))],'linewidth',2)
set(gca,'Xlim',[0 6e-5])
