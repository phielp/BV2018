function [x1,x2,y1,y2] = thetarho2endpoints(theta, rho, rows, cols)
    x1 = 0;
    y1 = (x1 * sin(theta) - rho) / cos(theta);
    x2 = cols;
    y2 = (x2 * sin(theta) - rho) / cos(theta);

    % Check if almost vertical (if so y = rows)
    if abs(y2 - y1) > cols
        y1 = 0;
        x1 = (rho + y1 * cos(theta)) / sin(theta);
        y2 = rows;
        x2 = (rho + y2 * cos(theta)) / sin(theta);
    end
end