function bach

%BACH A classic piece of music performed by an Ericsson T28 cellular phone. 
%
% This early GSM phone has a simple tone generator that makes it 
% suitable for segmentation and TFD analysis.

% Copyright Fredrik Gustafsson, Sigmoid AB
% $ Revision: v2023.4 $


help bach
load bach
Yt=estimate(tfd,y,'S',1500,'overlap',90);
plot(Yt)

