function [bestModel] = ransac(d1, d2, minPoints, iterations, fitThreshold, succesThreshold)
    % *The following description of parameters has been obtained from
    % https://en.wikipedia.org/wiki/Random_sample_consensus*
    % 
    % Given:
    %     data – a set of observed data points
    %     minPoints – minimum number of data points required to fit the model
    %     iterations – maximum number of iterations allowed in the algorithm
    %     fitThreshold – threshold value to determine when a data point fits a model
    %     succesThreshold – number of close data points required to assert that a model fits well to data
    % 
    % Return:
    %     bestfit – model parameters which best fit the data (or nul if no good model is found)

    bestModel = [];
    bestError = inf(); % the goal is to minimize this error

    % Go through the amount of iterations
    for i = 1:iterations
        % Randomly select points from data
        randomIndexes = randperm(minPoints,length(d1(1)));
        xy = d1(:,randomIndexes);
        xaya = d2(:,randomIndexes);

        % Inliers to which we will add points later
        inliers = randomIndexes;

        % Create model projection (and convert it to TSTRUCT)
        M = createProjectionMatrix(xy', xaya')';
        M = maketform('projective', M ./ M(3,3));

        % Go through all features and check if eucladian distance is smaller
        % then fitThreshold
        for featureIndex = 1:length(d1)

            % Only check features which the model is not fitted to
            if ~ismember(featureIndex, randomIndexes)
               % Do feature projection
               projected = tformfwd(M,d1(featureIndex), d2(featureIndex));

               % Calculate euclidean distance
               ed = euclideanDistance(d2(featureIndex), projected);

               % If it is an inlier we add it
               if ed < fitThreshold
                   inliers = [inliers featureIndex];
               end
            end
        end
        
        % if we have reached enough inliers for our threshold
        if length(inliers) > succesThreshold
            % Get all the new inlier points
            xy = d1(:, inliers);
            xaya = d2(:, inliers); 

            % Create the new model
            M = createProjectionMatrix(xy', xaya')';
            M = maketform('projective', M ./ M(3,3));

            % Create the new projection
            projected = tformfwd(M, xy, xaya);

            % Calculate the error (using euclidean)
            error = euclideanDistance(xaya, projected);

            % If the error is smaller then our best error we have a new best
            % model
            if error < bestError
                bestModel = M;
                bestError = error;
            end
        end
    end
    
    fprintf('the best error is : %d', bestError);
end