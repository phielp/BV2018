function [ newCube ] = transformCube( M, cube )
    for i=1:6
         face = cube(i,:,:); 
         face(1,:,4) = ones(1,5); % Add extra dimension of ones
         transformedFace = M*squeeze(face(1,:,:))'; % Rotate the face
        
         for j=1:5
            % Normalise the transformed face
            transformedFace(:,j) = 1/transformedFace(3,j) * transformedFace(:,j);
            
            % Set the new transformed cube coordinates
            newCube(i, j, 1) = transformedFace(1,j);
            newCube(i, j, 2) = transformedFace(2,j);
            newCube(i, j, 3) = cube(i,j,3)';
         end
     end
end


