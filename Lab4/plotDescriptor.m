% Function to plot keypoint descriptors
% (x-coord, y-coord, radius, angle)
function plotDescriptor(x0,y0,r,theta)
    ang = 0:0.01:2*pi; 
    xp = r * cos(ang);
    yp = r * sin(ang);
    plot(x0 + xp, y0 + yp);
    
    x1 = x0 + r * cos(theta);
    y1 = y0 + r * sin(theta);
    plot([x0, x1], [y0, y1]);
end