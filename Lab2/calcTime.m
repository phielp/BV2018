%% Calculate Elapsed Time
function elapsedTime = calcTime(image, sigma)
    tic;
    imfilter(image, Gauss(sigma), 'conv', 'replicate');
    elapsedTime = toc;
end