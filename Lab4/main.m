%% Lab 4
%
% Philip Bouman (10668667) & Jonas van Oenen (10670947)
%
% The code can be run by running the sections corresponding to the lab 
% questions.

%% Exercise 2 - Projectivity
% The createProjectionMatrix code was used to project the images
demo_mosaic(6);

%% Exercise 3 - SIFT

% load images
nw1 = rgb2gray(imread('nachtwacht1.jpg'));
nw2 = rgb2gray(imread('nachtwacht2.jpg'));

% get descriptors and features
[frame1, desc1] = vl_sift(single(nw1));
[frame2, desc2] = vl_sift(single(nw2));

% find matches
[matches, scores] = vl_ubcmatch(desc1, desc2);

% Get the coordinates for keypoints from first and second image
m1 = matches(1,:);
m1coords = frame1(:,m1);
m1coords = m1coords(1:2,:);
m2 = matches(2,:);
m2coords = frame2(:,m2);
m2coords = m2coords(1:2,:);

% visualize the matches
figure('name','Matches');
subplot(2,2,1);
imshow(nw1);
for i = 1:length(m1coords)
    text(m1coords(1, i), m1coords(2,i), sprintf('%02d',i), 'Color', 'green');
end
title('nachtwacht1.jpg');

subplot(2,2,2);
imshow(nw2);
for i = 1:length(m2coords)
    text(m2coords(1, i), m2coords(2,i), sprintf('%02d',i), 'Color', 'green');
end
title('nachtwacht2.jpg');

%% Mosaic images
figure('name', "N mosaic tests with random chosen features");
N = 10;
for t=1:N
    subplot(2,N/2,t);
    
    % Filter some random features features
    randArray = randi([1 40],1,10);
    matchA = m1coords(:,randArray(1:10));
    matchB = m2coords(:,randArray(1:10));

    % Create mosaic (and return projection matrix)
    projectionMatrix = mosaic(matchA, matchB);
    
    % Gather all features which were not used for the projection
    remainingIndexes = setdiff(1:40,randArray(1:10));
    
    % Project all remaining features
    projectedPoints = tformfwd(projectionMatrix, m1coords(:,remainingIndexes), m2coords(:,remainingIndexes));
    
    % Calculate the distance using euclidean
    distance = euclideanDistance(m2coords(:,remainingIndexes),projectedPoints);
    
    % Set the distance as the title
    title(distance)
end

%% Exercise 4 - RANSAC

% parameters
n_points = 8;
error = 1;
iter = 10;
thresh = 0.5;

% find best fit using RANSAC and transform
fit = ransac2(f1, f2, n_points, error, iter, thresh)';
T = maketform('projective', fit);

% visualize (from demo_mosaic.m)
[x y] = tformfwd(T,[1 size(f1,2)], [1 size(f1,1)]);

xdata = [min(1,x(1)) max(size(f2,2),x(2))];
ydata = [min(1,y(1)) max(size(f2,1),y(2))];
f12 = imtransform(f1,T,'Xdata',xdata,'YData',ydata);
f22 = imtransform(f2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
figure('name','RANSAC Mosaic');
imshow(max(f12,f22));

%% Util functions for plotting keypoint descriptors

figure('position', [75, 50, 1800, 900])
% Plot Nachtwacht1
subplot(1,2,1);
imshow(nw1,'InitialMagnification','fit');
labels = cellstr(num2str([1:length(frame1)]'));
hold on
for i=1:length(frame1)
    % get keypoint descriptor
    point = frame1(1:4,i);
    % plot keypoint descriptor
    plotDescriptor(point(1), point(2), point(3), point(4));
    % plot labels
    text(point(1), point(2), labels(i));
end
hold off

% Plot Nachtwacht2
subplot(1,2,2);
imshow(nw2,'InitialMagnification','fit');
labels = cellstr(num2str([1:length(frame2)]'));
hold on
for i=1:length(frame2)
    % get keypoint descriptor
    point = frame2(1:4,i);
    % plot keypoint descriptor
    plotDescriptor(point(1), point(2), point(3), point(4));
    % plot labels
    text(point(1), point(2), labels(i));
end
hold off
  