function [components] = PrincipalComponentAnalysis(data, dimensions)
    [m n] = size(data);
    
    % Calculate the mean and standard deviation
    meanData = mean(data, dimensions); % Every column is mean for all 300 images on that pixel
%     stdData = std(data);
    
    % Substract the mean from our images
    centeredData = data - repmat(meanData,1, m);
%     centeredData = (data - repmat(meanData,[m 1])) ./ repmat(stdData,[m 1]);
    
    % Calculate svd
    [~,S,V] = svd(centeredData);
    
    % Variances
    S = diag(S);
    Vatiances = S .* S;
    
    % project
    components = V' * data';
    
end