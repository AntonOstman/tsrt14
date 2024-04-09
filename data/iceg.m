function iceg

%ICEG Human heart activity (intra-cardiac electrogram)
%
% There is a 50 Hz disturbance present. 
% An EP (Electrophysiology
% Electrophysiology) study is a recording of
% the electrical activity the heart to find
% out the cause of rhythm disturbance and the
% best treatment for it. Catheters are about
% 1.25 m long and the electrodes are located
% near the tip. These electrodes come in
% contact with the patient's heart tissue.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $

load iceg
subplot(2,1,1)
plot(y)
subplot(2,1,2)
plot(ft(y),'Xlim',[0 150])
