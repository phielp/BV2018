function [components, variances] = PrincipalComponentAnalysis(data, dimensions)
    [~,n] = size(data);
    
    % Calculate the mean and standard deviation
    meanData = mean(data, dimensions); % Every column is mean for all 300 images on that pixel
    
    % Substract the mean from our images
    centeredData = data - repmat(meanData,1, n);
     
    % normalize
    normalized = centeredData' / sqrt(n);
    
    % Calculate svd
    [~,S,V] = svd(normalized);
    
    % Variances
    S = diag(S);
    variances = S .* S;
    
    % project
    components = (V' * centeredData)';
end