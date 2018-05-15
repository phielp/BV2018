%% Load data
load 'attachments/omni'

trainingSet = ones(300,16800);
testSet = ones(250,16800);

% Parse data to training and test sets
for i=1:length(images)
    image = images{i}.img;
    if i < 301
        trainingSet(i,:) = reshape(image,1,16800);
    else
        testSet(i-300,:) = reshape(image,1,16800);
    end
end
%% PCA

% First 25 dimensions
d = 25;

% Built in matlab version
% [coeff, score] = pca(trainingSet, 'numComponents', d);
coeff = PrincipalComponentAnalysis(trainingSet, 25);

% Show first 9 PCA vectors
for j=1:9
    subplot(2,5,j)
    coeff(:,j) = coeff(:,j) / max(coeff(:,j)); % Normalize
    imshow(reshape(coeff(:,j), 112,150))
end

