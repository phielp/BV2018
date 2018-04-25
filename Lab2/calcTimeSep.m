%% Calculate Elapsed Time
function elapsedTime = calcTimeSep(image, sigma)
    tic;
    g1 = Gauss1(sigma);
    B = imfilter(image, g1', 'conv', 'replicate');
    imfilter(B, g1, 'conv', 'replicate');
    elapsedTime = toc;
end