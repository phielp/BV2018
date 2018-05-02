function h = hough (im , Thresh , nrho , ntheta )
    % HOUGH
    %
    % Function takes a grey scale image , constructs an edge map by applying
    % the Canny detector , and then constructs a Hough transform for finding
    % lines in the image .
    %
    % Usage : h = hough (im , Thresh , nrho , ntheta )
    %
    % arguments :
    %   im - The grey scale image to be transformed
    %   Thresh - A 2 -vector giving the upper and lower
    %           hysteresis threshold values for edge ()
    %   nrho - Number of quantised levels of rho to use
    %   ntheta - Number of quantised levels of theta to use
    %
    % returns ;
    %   h - The Hough transform
    % ...
    
    % Colums and rows
    [rows, cols] = size(im);
    
    rhomax = sqrt ( rows ^2 + cols ^2); % The maximum possible value of rho.
    drho = 2* rhomax /( nrho -1);       % The increment in rho between successive
                                        % entries in the accumulator matrix .
                                        % Remember we go between +- rhomax .
    
    dtheta = pi/ ntheta ;                   % The increment in theta between entries .
    thetas = [0: dtheta :(pi - dtheta )];   % Array of theta values across the
                                            % accumulator matrix .
    
    % Detect edges using the canny edge method in the image with specified threshholds 
    imageEdges = edge(im,'canny', Thresh);
    
    % Create empty accumulator
    accumulatorArray = zeros(nrho,ntheta);
    
    [x, y] = find(imageEdges);
    for i=1:length(x)
        for j=1:length(thetas)
            rho = x(i)*sin(thetas(j))-y(i)*cos(thetas(j));
            
            rhoindex = round (rho/ drho + nrho /2);
            thetaindex = round ( thetas(j) / dtheta + 1);  
            
            accumulatorArray(rhoindex,thetaindex) = accumulatorArray(rhoindex,thetaindex)+1;
        end
    end
    
    h = accumulatorArray;
end