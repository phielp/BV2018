function r = myAffine(image, x1, y1, x2, y2, x3, y3, m, n, method)
    r = zeros(n, m);
    A = [x1, y1, 1; x2, y2, 1; x3, y3, 1;]';
    B = [1, 1; m, 1; 1, n]';
    X = B / A;
    
    numberOfIndices = m*n;
    [XI, YI] = meshgrid(1:m, 1:n);
    indices = [XI(:)'; YI(:)'; ones(1, numberOfIndices)];
    transformedIndices = X * indices;
    
    for i= 1:numberOfIndices
        r(indices(2,i), indices(1, i)) = pixelValue(image, ...
            transformedIndices(2, i), transformedIndices(1, i), method);
    end
end
   