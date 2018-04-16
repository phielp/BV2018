%% Image Rotation Margins
% Calculates the height and width of an image after rotation with
% a specified angle. The top and left margins are half of the difference
% in height and width respectively.
% Returns the calculated height and width and 
% the top and left margins.
function [newHeight, newWidth, ...
    topMargin, leftMargin] = imageRotationMargins(image, angle)

    [height, width] = size(image);
    angle = abs(angle);
    newWidth = abs(height * cos(angle) + width * sin(angle));
    newHeight = abs(height * sin(angle) + width * cos(angle));
    
    topMargin = ceil((newWidth - width) / 2);
    leftMargin = ceil((newHeight - height) / 2);
    newWidth = width + leftMargin*2;
    newHeight = height + topMargin*2;
end