function G = Gauss(sigma)
    
    radius = ceil(3 * sigma);

    x = -radius:radius;
    y = -radius:radius;
    [X, Y] = meshgrid(x, y);
    G = exp(-((X.^2 + Y.^2)) ./ (2*sigma^2));
    G = G ./ ((2*pi*sigma)^2);
    G = (1 / sum(G(:))) * G;
    
end