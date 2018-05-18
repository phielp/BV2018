%% Lab 5 - Load data and reshaping images
load('attachments/omni');

train_set = ones(300,16800);
test_set = ones(250,16800);

% Parse data to training and test sets
for i=1:length(images)
    image = images{i}.img;
    if i < 301
        train_set(i,:) = normalize(reshape(image,1,16800));
    else
        test_set(i-300,:) = normalize(reshape(image,1,16800));
    end
end

%% PCA Matlab - this uses the built in matlab pca method
% NumComponents set the dimensionality of the coefficients
[coeff, components, eigenvalues] = pca(train_set, 'NumComponents', 20);
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
[projectedData, components, eigenvalues] = PrincipalComponentAnalysis(train_set, 50);
for i = 1:size(projectedData, 2)
    projectedData(:, i) = projectedData(:, i)/max(projectedData(:, i));
end

% Plot 9 PCA vectors as images
figure;
for i = 1:9
    subplot(2,5,i)
    imshow(reshape(projectedData(:, i), 112, 150));
end

% Plot the first 50 eigenvalues
figure;
plot(eigenvalues(1:50));
title("First 50 eigenvalues")

%% Speed comparison
tic
r1 = NaiveImageCorrelation(train_set);
toc

tic
r2 = pcaImageCorrelation(projectedData', components);
toc

% Print 5 results for naive correlation
figure('name','naive');
indexes = randi([1,300],1,5);
for i=1:5
    subplot(2,5,i)
    im = reshape(train_set(r1(indexes(i),1),:), 112, 150);
    imshow(im);
    title('Original image')
    
    subplot(2,5,i+5)
    im2 = reshape(train_set(r1(indexes(i),2),:), 112, 150);
    imshow(im2)
    title('matched image')
end

% Print 5 results for pca correlation
figure('name','pca');
for i=1:5
    subplot(2,5,i)
    im = reshape(train_set(r2(indexes(i),1),:), 112, 150);
    imshow(im)
    title('Original image')
    
    subplot(2,5,i+5)
    im2 = reshape(train_set(r2(indexes(i),2),:), 112, 150);
    imshow(im2)
    title('matched image')
end

%% Positioning with Nearest Neigbour
imagestruct = [ images{:}];
positions = vertcat ( imagestruct . position );


%% ****HELPER FUNCTIONS FOR CORRELATION****
%% Naive immage correlation
function [naive_image_correlations] = NaiveImageCorrelation(train_set)
    l = length(train_set(:,1));
    naive_image_correlations = [1:l;ones(1,l)]';
    for i=1:l
        image = train_set(i,:);
        best_sim = 0; 
        best_match = 0;

        % Compare image to all other images in set
        for j=1:l
            comparisonImage = train_set(j,:);

            % Check if the images are not the same
            if j~=i
                sim = dot(image', comparisonImage); %similarity

                % Check if the new similarity is the best
                if sim > best_sim
                    best_match = j;
                    best_sim = sim;
                end
            end
        end

        naive_image_correlations(i,2) = best_match;
    end
end

%% PCA image correlation
function [pca_image_correlations] = pcaImageCorrelation(train_set, pc)
    l = length(train_set(:,1));
    pca_image_correlations = [1:l;ones(1,l)]';
    for i=1:l
        image = train_set(i,:);
        best_sim = 0;
        best_match = 0;

        % Compare image to all other images in set
        for j=1:l
            comparisonImage = pc(j,:);

            % Check if the images are not the same
            if j~=i
                sim = dot(image(1:length(pc(1,:)))', comparisonImage); %similarity

                % Check if the new similarity is the best
                if sim > best_sim
                    best_match = j;
                    best_sim = sim;
                end
            end
        end

        pca_image_correlations(i,2) = best_match;
    end
end