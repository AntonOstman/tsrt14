function y = model1(t, x, u, th)
   y =   [sqrt((x(1,:)-th(1)).^2+(x(2,:)-th(2)).^2) + x(3,:);    
          sqrt((x(1,:)-th(3)).^2+(x(2,:)-th(4)).^2) + x(3,:);   
          sqrt((x(1,:)-th(5)).^2+(x(2,:)-th(6)).^2) + x(3,:);
          sqrt((x(1,:)-th(7)).^2+(x(2,:)-th(8)).^2) + x(3,:)];
end