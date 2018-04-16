%% Pixel Value
% Returns pixel value at specified (x,y) coordinates.
function color = pixelValue(image, x, y, interpolationMethod, borderMethod)
    
    % Set periodic to be the default border method.
    if ~exist('borderMethod', 'var'), borderMethod = 'constant'; end

    [m, n] = size(image);
    % check if coordinates are in image
    if ~inImage(size(image), x, y, interpolationMethod)
        switch (borderMethod)
            case 'constant'
                color = 0;
            case 'nearest'
                x = floor(valueInRange(1, m, x));
                y = floor(valueInRange(1, n, y));
                color = image(x, y);
            case 'periodic'
                if ~(x >= 1 && x <= m)
                    x = valueInRange(1, m, abs(abs(x) - m));
                end
                if ~(y >=1 && y <= n)
                    y = valueInRange(1, n, abs(abs(y) - n));
                end
                color = image(floor(x), floor(y));
        end
        return
    end
    
    switch (interpolationMethod)
        case 'nearest'
            color = image(floor(x + 0.5), floor(y + 0.5));
            return
        case 'linear'
            k = floor(x);
            a = x - k;
            l = floor(y);
            b = y - l;
            color = (1-a)*(1-b)*image(k,l) + (1-a)*b*image(k, l+1) ...
                    + a*b*image(k+1, l+1) + a*(1-b)*image(k+1, l);
            return
    end
end