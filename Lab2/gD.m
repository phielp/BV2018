function result = gD(f, sigma, xorder, yorder)

    radius = round(3 * sigma);
    x = -radius:radius;
    
    g = Gauss1(sigma);
    dx = -x.* g ./ sigma^2;
    dxx = ((x .^2 ./ sigma^4) - (1/sigma^2)) .* g;
    if xorder == 0
        result = imfilter(f, g, 'conv', 'replicate');
    end
    if yorder == 0
        result = imfilter(f, g', 'conv', 'replicate');
    end
    if xorder == 1
        result = imfilter(f, dx, 'conv', 'replicate');
    end
    if yorder == 1
        result = imfilter(f, dx', 'conv', 'replicate');
    end
    if xorder == 2
        result = imfilter(f, dxx, 'conv', 'replicate');
    end
    if yorder == 2
        result = imfilter(f, dxx', 'conv', 'replicate');
    end
end