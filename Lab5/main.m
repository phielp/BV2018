%% Lab 5

%% Add data folder to path
addpath('attachments');

%% Load data and reshaping images
data = load('omni.mat');

% Reshaping data 2.4
% Create training set
train_set = zeros(300, 16800);
for i = 1:300
      train_set(i, :) = reshape(data.images{1,i}.img, 1, 16800);
end
% Create testing set (test set index is index+training set size)
test_set = zeros(250, 16800);
for i = 1:250
    train_set(i, :) = reshape(data.images{1,i+300}.img, 1, 16800);
end

%% PCA
% NumComponents set the dimensionality of the coefficients
[coeff, ~, eigenvalues] = pca(train_set, 'NumComponents', 50);
for i = 1:size(coeff, 2)
    coeff(:, i) = coeff(:, i)/max(coeff(:, i));
end

% plot 5 PCA vectors as images
figure
for i = 1:5
    subplot(2,5,i)
    imshow(reshape(coeff(:, i), 112, 150));
end

% plot next 4 PCA vectors as images
for i = 6:9
    subplot(2,5,i)
    imshow(reshape(coeff(:, i), 112, 150));
end

%%
plot(eigenvalues(1:50));

%% From A Tutorial on Principal Component Analysis
[M, N] = size(train_set);
mn = mean(train_set,2);
data = train_set -repmat(mn,1,N);

Y = data' / sqrt(N-1);

[u,S,PC] = svd(Y);

S = diag(S);
V = S .* S;

signals = PC' * data;
signals = signals'

%% plot 5 PCA vectors as images
figure
for i = 1:5
    subplot(2,5,i)
    imshow(reshape(signals(:, i), 112, 150));
end

% plot next 4 PCA vectors as images
for i = 6:9
    subplot(2,5,i)
    imshow(reshape(signals(:, i), 112, 150));
end
