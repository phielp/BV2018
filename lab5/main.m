%% Lab 5 - Load data and reshaping images
load('attachments/omni');

train_set = ones(300,16800);
test_set = ones(250,16800);

% Parse data to training and test sets
for i=1:length(images)
    image = images{i}.img;
    if i < 301
        train_set(i,:) = reshape(image,1,16800);
    else
        test_set(i-300,:) = reshape(image,1,16800);
    end
end

%% PCA Matlab
% NumComponents set the dimensionality of the coefficients
[coeff, ~, eigenvalues] = pca(train_set, 'NumComponents', 50);
for i = 1:size(coeff, 2)
    coeff(:, i) = coeff(:, i)/max(coeff(:, i));
end

% Plot 9 PCA vectors as images
figure;
for i = 1:9
    subplot(2,5,i)
    imshow(reshape(coeff(:, i), 112, 150));
end

% Plot the first 50 eigenvalues
figure;
plot(eigenvalues(1:50));
title("First 50 eigenvalues")

%% PCA implementation
figure;
[coeff, eigenvalues] = PrincipalComponentAnalysis(train_set, 2);
for i = 1:size(coeff, 2)
    coeff(:, i) = coeff(:, i)/max(coeff(:, i));
end

% Plot 9 PCA vectors as images
figure;
for i = 1:9
    subplot(2,5,i)
    imshow(reshape(coeff(:, i), 112, 150));
end

% Plot the first 50 eigenvalues
figure;
plot(eigenvalues(1:50));
title("First 50 eigenvalues")


%% Naive immage correlation
tic
l = length(train_set(:,1));
image_correlations = [1:l;ones(1,l)]';
for i=1:l
    image = train_set(i,:);
    best_sim = 0;
    best_match = 0;
    
    % Compare image to all other images in set
    for j=1:l
        comparisonImage = train_set(j,:);
        
        % Check if the images are not the same
        if j~=i
            sim = dot(image, comparisonImage); %similarity
            
            % Check if the new similarity is the best
            if sim > best_sim
                best_match = j;
                best_sim = sim;
            end
        end
    end
    
    image_correlations(i,2) = best_match;
end
toc

%% PCA image correlation
tic
l = length(train_set(:,1));
image_correlations = [1:l;ones(1,l)]';
for i=1:l
    image = coeff(:,i);
    best_sim = 0;
    best_match = 0;
    
    % Compare image to all other images in set
    for j=1:l
        comparisonImage = train_set(j,:);
        
        % Check if the images are not the same
        if j~=i
            sim = dot(image, comparisonImage); %similarity
            
            % Check if the new similarity is the best
            if sim > best_sim
                best_match = j;
                best_sim = sim;
            end
        end
    end
    
    image_correlations(i,2) = best_match;
end
toc
%% Positioning with Nearest Neigbour
imagestruct = [ images{:}];
positions = vertcat ( imagestruct . position );

