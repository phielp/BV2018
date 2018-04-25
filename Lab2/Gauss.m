%% Gaussian Kernel
function G = Gauss(sigma)        
    
    % An appropriate grid size would be 3 times sigma,
    % which is based on the three-sigma rule.
    % 99.7% of the data are within 3 standard deviations
    % of the mean.
    radius = ceil(3 * sigma);
    % Using this radius results in a kernel size of 
    % (radius*2+1)x(radius*2+1)
    x = -radius:radius;
    y = -radius:radius;
    % Create a sampling grid.
    [X, Y] = meshgrid(x, y);
    % Determine the scale.
    G = exp(-((X.^2 + Y.^2)) ./ (2*sigma^2));
    G = G ./ (2*pi*sigma)^2;
    G = (1 / sum(G(:))) * G;
end