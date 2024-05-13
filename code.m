
load xhat.mat
load meas.mat

mean(meas.acc(:, ~any(isnan(meas.acc), 1)), 2)

Ts = 0.01;
cutoff = 4/Ts;

meas.t = meas.t(:,1:cutoff);
meas.gyr = meas.gyr(:,1:cutoff);
meas.acc = meas.acc(:,1:cutoff);
meas.orient = meas.orient(:,1:cutoff);
meas.mag = meas.mag(:,1:cutoff);

xhat.t = xhat.t(:,1:cutoff);
xhat.x = xhat.x(:,1:cutoff);
xhat.P = xhat.P(:,:,1:cutoff);


figure(1)
subplot(3,1,1)
plot(meas.t, meas.acc)
subplot(3,1,2)
plot(meas.t, meas.gyr)
subplot(3,1,3)
plot(meas.t, meas.mag)



figure(2)
subplot(3,3,1)
hist(meas.acc(1,:))
subplot(3,3,2)
hist(meas.acc(2,:))
subplot(3,3,3)
hist(meas.acc(3,:))

subplot(3,3,4)
hist(meas.gyr(1,:))
subplot(3,3,5)
hist(meas.gyr(2,:))
subplot(3,3,6)
hist(meas.gyr(3,:))

subplot(3,3,7)
hist(meas.mag(1,1:cutoff))
subplot(3,3,8)
hist(meas.mag(2,1:cutoff))
subplot(3,3,9)
hist(meas.mag(3,1:cutoff))


%{
mean(meas.acc(:, ~any(isnan(meas.acc), 1)), 2)

ans =

    0.0085
    0.1544
    9.8807

mean(meas.gyr(:, ~any(isnan(meas.gyr), 1)), 2)

ans =

   1.0e-03 *

   -0.5136
   -0.0326
    0.4701

mean(meas.mag(:, ~any(isnan(meas.mag), 1)), 2)

ans =

  -37.6784
  -21.6402
  -39.9535

%}






