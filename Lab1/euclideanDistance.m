%% Calculates Euclidean distance
% Calculates the Euclidean distance between a
% transformed image and its original.
function distance = euclideanDistance(original, transformedImage)
    difference = (original - transformedImage).^2;
    distance = sum(difference(:));
end