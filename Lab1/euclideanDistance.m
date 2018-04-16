%% Calculates Euclidean distance
% Calculates the Euclidean distance between a
% transformed image and its original.
function distance = euclideanDistance(originalMatrix, newMatrix)

    originalSize = size(originalMatrix);
    newSize = size(newMatrix);
    
    assert(originalSize(1) == newSize(1), 'Matrices must be of same size.');
    assert(originalSize(2) == newSize(2), 'Matrices must be of same size.');
    
    D = pdist2(originalMatrix, newMatrix, 'euclidean');
    distance = sqrt(sum(D(:)));
end