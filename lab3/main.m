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
% parameters
Thresh = [0.1, 0.9];
thresh = 50;
nrho = 250;
ntheta = 250;

% Use shapes.png image
shapes = rgb2gray(im2double(imread('attachments/shapes.png')));

% Do hough transform
h = hough(shapes, Thresh, nrho, ntheta);

% Estime hough lines
lines = houghlines(shapes, h, thresh);

% Plot lines
figure;
subplot(1,2,1)
imshow(shapes);

subplot(1,2,2);
hold on
for i = 1:size(lines, 1)
    line = lines(i,:);
    x1 = 0;
    y1 = (-line(1) * x1 - line(3)) / line(2);
    x2 = size(shapes, 2);
    y2 = (-line(1) * x2 - line(3)) / line(2);
    plot([x1 x2], [y1 y2], 'Color', 'r');
end
hold off
