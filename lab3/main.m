%% Exercise 2
% Parameters
thresh = [0.1, 0.9];
nrho = 250;
ntheta = 250;

% Image 1 - shapes
shapes = rgb2gray(im2double(imread('attachments/shapes.png')));

houghImage = hough(shapes, thresh, nrho, ntheta);
figure;
subplot(3,2,1);
imshow(shapes);
title('Shapes image');

subplot(3,2,2);
imshow(houghImage,[]);
title('Hough transform on shapes image');

% Image 2 - Billboard 
billboard = rgb2gray(im2double(imread('attachments/billboard.png')));

houghImage = hough(billboard, thresh, nrho, ntheta);
subplot(3,2,3);
imshow(billboard);
title('billboard image');

subplot(3,2,4);
imshow(houghImage,[]);
title('Hough transform on billboard image');

% Image 3 - Box 
box = rgb2gray(im2double(imread('attachments/box.png')));

houghImage = hough(box, thresh, nrho, ntheta);
subplot(3,2,5);
imshow(box);
title('box image');

subplot(3,2,6);
imshow(houghImage,[]);
title('Hough transform on box image');

%% Exercise 3
