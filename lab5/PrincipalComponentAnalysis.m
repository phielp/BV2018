function [projectedData, components, eigenValues] = PrincipalComponentAnalysis(data, dimensions)
    [~,n] = size(data);
    
    % Calculate the mean and standard deviation
    meanData = mean(data, 2); % Every column is mean for all 300 images on that pixel
    
    % Substract the mean from our images
    centeredData = data - repmat(meanData,1, n);
    normalized = centeredData' / sqrt(n);
    
    % Calculate svd
    [~,S,components] = svd(normalized);
    
    % Eigenvalues
    S = diag(S);
    eigenValues = S .* S;
    
    % project our data 
    projectedData = (components' * centeredData)';
    
    % Return only the asked dimensions
    components = components(:,1:dimensions);
   
end