function houghlines (im , h, thresh )
    % HOUGHLINES
    %
    % Function takes an image and its Hough transform , finds the
    % significant lines and draws them over the image
    %
    % Usage : houghlines (im , h, thresh )
    %
    % arguments :
    %       im - The original image
    %       h - Its Hough Transform
    %       thresh - The threshold level to use in the Hough Transform
    %                to decide whether an edge is significant
    
    % Calculate rho max based on the size of the image
    [rows, cols] = size(im);
    rhomax = sqrt ( rows ^2 + cols ^2); 
    
    % Calculate drho and dtheta
    [nrho, ntheta] = size(h);
    drho = 2* rhomax /( nrho -1);       
    dtheta = pi/ ntheta ;                 
    
    % Apply the threshold to the entire image
    h(h < thresh) = 0;
    
    % Create label connected regions
    nregions = bwlabel(h);
    
    for n = 1: nregions
        % Form a mask for each individual region .
        mask = bwl == n;    
        region = mask .* h; 
        
        % Find the absolute max
        [rhoindex, thetaindex] = find(region == max(max(region)));
        rhoindex = round(mean(rhoindex));
        thetaindex = round(mean(thetaindex));
        
        % Obtain rho and theta
        rho = drho * (rhoindex - nrho / 2);
        theta = (thetaindex - 1) * dtheta;
        
        [x1, y1, x2, y2] = thetarho2endpoints(theta, rho, rows, cols); 
        
    end
end