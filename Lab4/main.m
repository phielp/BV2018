%% Exercise 2
% The createProjectionMatrix code was used to project the images
demo_mosaic(4);

%% Exercise 3

% load images
nw1 = rgb2gray(imread('nachtwacht1.jpg'));
nw2 = rgb2gray(imread('nachtwacht2.jpg'));

% get descriptors and features
[frame1, desc1] = vl_sift(single(nw1));
[frame2, desc2] = vl_sift(single(nw2));

% find matches
[matches, scores] = vl_ubcmatch(desc1, desc2);
    
% get the coordinates
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

% Mosaic images
figure('name', "N mosaic tests with random chosen features");
N = 10;
for t=1:N
    subplot(2,N/2,t);
    % Filter some random features features
    randArray = randi([1 40],1,10);
    matchA = m1coords(:,randArray(1:10));
    matchB = m2coords(:,randArray(1:10));

    % create mosaic
    mosaic(matchA, matchB);
end
%% LoG
x = 2;
y = 3;
t = 0;

result = (1 / (2*pi*t)) * exp(-(x^2 + y^2) / 2*t);
result

filter = fspecial('log',[3 3],0.5);
filtered_img=imfilter(image,filter,'conv'); 
imshow(filtered_img);
