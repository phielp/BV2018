%% Adds Border to Image
% Calculates the new dimension after a rotation of a specified angle.
% Positions the original image in the center of this new dimension.
function borderedImage = borderImage(image, angle)

    [newHeight, newWidth, topMargin, ...
        leftMargin] = imageRotationMargins(image, angle);
    
    borderedImage = zeros(newHeight, newWidth);
    borderedImage(topMargin+1:(newHeight-topMargin), ...
        leftMargin+1:(newWidth-leftMargin)) = image;
end