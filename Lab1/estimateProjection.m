%% Estimate projection
function projection = estimateProjection(cube, M)
    
    projection = zeros(6,5,3);
    for i = 1:length(cube(:,1,:))
        for j = 1:length(cube(1,:,:))
            cubeCoords = [cube(i,j,1); cube(i,j,2); cube(i,j,3); 1];
            projectedCoords = M * cubeCoords;
            projectedCoords = projectedCoords / projectedCoords(3);
            projection(i, j, :) = projectedCoords;
        end
    end
end