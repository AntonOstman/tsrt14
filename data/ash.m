function ash

% ASH Environmental process signals where ash is mixed with water
%
% The ash from burnt wood cannot be recycled back to nature
% directly, mainly because of its volatility.
% By mixing ash with water a granular material is obtained. Swedish
% district heatings plants produce about 500 000 tons of ash each
% year, and soon there will be a 30 Dollar penalty fee for deposit it as
% waste, which is an economical incentive for recycling.
% In the water mixing process, it is of utmost importance to get
% the right mixture. When too much water is added, the mixture
% becomes useless. The idea is to monitor the mixture's viscosity
% indirectly, by measuring the power consumed  by the electric
% motor in the mixer. When the dynamics between input water and
% consumed power changes, it is time to stop adding water
% immediately.
%
% For change detection, we can use an ARX model.
% However, a better and semi-physical model is to assume that the
% power is proportional to the amount of water plus an offset. When
% the proportional coefficient changes, the granulation material is
% finished.
%
% DATA:   Power  Water  Time
% Case 1: y1     u1     t1
% Case 2: y2     u2     t2
% Case 3: y3     u3     t3

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $


help ash
load ash
figure
subplot(3,1,1)
plot(y1)
subplot(3,1,2)
plot(y2)
subplot(3,1,3)
plot(y3)
