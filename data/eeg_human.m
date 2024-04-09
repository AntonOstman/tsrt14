function eeg_human

%EEG_HUMAN Activity in human brain with a controlled  stimulus
%
% The EEG signal y shows the brain activity of a human test subject
% who is first looking at something stimulating and the neurons are
% processing the information in the visual cortex, and only noise is
% seen in the measurements. At time tb=387 samples, the light is
% turned off, and the neurons start a 10 Hz periodical 'rest rhytm'.
% The delay between tb and the start time when this rest rhytm starts
% is individual and is affected by certain deseases as Alzheimer.
%
% The MC field contains 20 experiments on different individuals.
%
% Data are provided by Dr Pasi Karjalainen, Dept of Applied Physics,
% University of Kuopio, Finland.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $


load eeg_human
help eeg_human
Y1=ft(y(1:387));
Y2=ft(y(388:size(y)));
figure
subplot(2,1,1)
plot(y)
title('EEG for one patient')
subplot(2,1,2)
plot(Y1,Y2)
axis([8 12 0 2000])

figure
subplot(2,1,1)
plot(y,'conf',90,'conftype','band')
title('EEG for one patient')
subplot(2,1,2)
plot(Y1,Y2,'conf',90,'conftype','band')
axis([8 12 0 2000])
