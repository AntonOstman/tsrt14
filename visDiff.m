function visDiff(xhat, meas)
% VISDIFF Visualize the difference between your and Google's orienation
%
% Plots angular difference and the difference in Euler angles for yours
% and Google's orientation estimate.  The input is the two output from the
% provided template.

  I = ~any(isnan(meas.orient), 1);
  meas.orient = interp1(meas.t(I), meas.orient(:, I)', xhat.t, 'spline', 'extrap')';
  meas.orient = meas.orient./sqrt(sum(meas.orient.^2, 1));
  diffq = invq_mult_q(xhat.x, meas.orient);
  diffAngle = 2*acosd(diffq(1, :));

  subplot(2, 1, 1);
  plot(xhat.t, diffAngle);
  title('Total Orientation Difference');
  xlabel('Time [s]');
  ylabel('Error [deg]');

  subplot(2, 1, 2);
  plot(xhat.t, rad2deg(q2euler(diffq))');
  xlabel('Time [s]');
  ylabel('Euler angle [deg]');
  title('Orientation Difference: Euler angles');
  legend('Yaw', 'Pitch', 'Roll');
end

function c = invq_mult_q(a, b)
  c = [-a(1,:).*b(1,:) - a(2,:).*b(2,:) - a(3,:).*b(3,:) - a(4,:).*b(4,:);
       -a(1,:).*b(2,:) + a(2,:).*b(1,:) + a(3,:).*b(4,:) - a(4,:).*b(3,:);
       -a(1,:).*b(3,:) - a(2,:).*b(4,:) + a(3,:).*b(1,:) + a(4,:).*b(2,:);
       -a(1,:).*b(4,:) + a(2,:).*b(3,:) - a(3,:).*b(2,:) + a(4,:).*b(1,:)];
  c(:, c(1, :)<0) = -c(:, c(1, :)<0);  % Normalize
end
