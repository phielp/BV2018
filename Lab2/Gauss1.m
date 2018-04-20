function G = Gauss1(sigma)
    
    radius = round(3 * sigma);
    x = -radius:radius;

    G = exp(-((x.^2)) ./ (2*sigma^2));
    G = G ./ (sqrt(2*pi*sigma));
    G = (1 / sum(G(:))) * G;
end