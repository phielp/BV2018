%% Image Rotation
% Performs a rotation transformation with a 
% specified angle on a provided image around
% its center.
% If addMargins is enabled, then the dimensions after rotation of 
% the image are calculated, together with the top and left margins 
% (for correct positioning).
function rotatedImage = rotateImage(image, angle, ...
                        interpolationMethod, borderMethod, addMargins)
    
    % Set periodic to be the default border method.
    if ~exist('borderMethod', 'var'), borderMethod = 'constant'; end
    % Set the addMargins flag to false by default
    if ~exist('addMargins', 'var'), addMargins = false; end
    if addMargins
        [m, n, topMargin, leftMargin] = imageRotationMargins(image, angle);
    else;
        [m, n] = size(image);
        topMargin = 0;
        leftMargin = 0;
    end
    
    center = round([m, n]/2);
    numberOfIndices = m*n;
    
    R = rot(angle);
    [X, Y] = meshgrid(1:m, 1:n);
    indices = [X(:)'; Y(:)'; ones(1, numberOfIndices)];
    
    % Added an additional translation for positioning the image
    % after rotation if margins are specified.
    rotatedIndices = trans(-[topMargin, leftMargin]) * ...
                     trans(center) * (R * (trans(-center) * indices));
    rotatedImage = zeros(n, m);
    
    for i = 1:numberOfIndices
        rotatedImage(indices(2, i), indices(1, i)) = pixelValue(image, ...
            rotatedIndices(2, i), rotatedIndices(1, i), ...
            interpolationMethod, borderMethod);
    end
end