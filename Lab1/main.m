function main()
    %% Exercise 1
    close all
    img = im2double(imread('cameraman.tif'));
    imageAutumn = imread ( 'autumn .tif' );
    imageAutumn = im2double ( rgb2gray (imageAutumn) );
    
    %% Question 2.1.1 / Question 2.1.2
    % Check out the implementation of
    % pixelValue(image, x, y, interpolationMethod, borderMethod)
    
    %% Question 2.1.3
    % Comparement of (bi)linear and nearest profile.
    figure('name', 'Interpolation Profiles (nearest:b vs. linear:r)')
    hold on;
    plot(myProfile(imageAutumn, 100, 100, 120, 120, 200, 'nearest', 'constant'), 'b');
    plot(myProfile(imageAutumn, 100, 100, 120, 120, 200, 'linear', 'constant'), 'r');
    hold off;
    
    %% Question 2.1.4
    % pixelValue supports three different border methods: constant,
    % nearest and periodic. See report for discussion on the different 
    % methods.
    figure('name', 'Border Methods (nearest:b vs. periodic:r)')
    hold on;
    plot(profile(img, -100, -100, 300, 300, 200, 'nearest', 'nearest'), 'b');
    plot(profile(img, -100, -100, 300, 300, 200, 'nearest', 'periodic'), 'r');
    hold off;
    
    %% Question 3.1.1 / Question 3.1.2
    % See the implementation of 
    % rotateImage(image, angle, interpolationMethod, borderMethod, addMargins)
    rotatedImage = rotateImage(img, deg2rad(45), 'linear');
    figure('name', 'Q3.1.2 / Q3.1.2 : pi/6 angle')
    imshow(rotatedImage)
    
    %% Question 3.1.3
    % We've added an addMargins flag to rotateImage() which results
    % in a complete picture as output. See rotateImage() for further details.
    figure('name', 'Image after 45deg rotation w/ constant border method')
    rotatedImage = rotateImage(img, pi/4, 'linear', 'constant', true);
    imshow(rotatedImage)
    figure('name', 'Image after 45deg rotation w/ nearest border method')
    rotatedImage = rotateImage(img, pi/4, 'linear', 'nearest', true);
    imshow(rotatedImage)
    figure('name', 'Image after 45deg rotation w/ periodic border method')
    rotatedImage = rotateImage(img, pi/4, 'linear', 'periodic', true);
    imshow(rotatedImage)
    
    %% Question 3.1.4
    % Processing time performance measure of both interpolation methods.
    disp('Processing time for nearest interpolation:')
    tic;
    rotateImage(img, pi/4, 'nearest');
    toc;
    disp('Processing time for (bi)linear interpolation:')
    tic;
    rotateImage(img, pi/4, 'linear');
    toc;
    
    %% Question 3.1.5
    % The distance, between the original and interpolated version of 
    % the image is measured using Euclidean distance.
    imgNearest = rotateImage(img, pi/4, 'nearest', 'constant', true);
    imgNearest = rotateImage(imgNearest, -pi/4, 'nearest');
    
    imgLinear = rotateImage(img, pi/4, 'linear', 'constant', true);
    imgLinear = rotateImage(imgLinear, -pi/4, 'linear');
 
    borderedImage = borderImage(img, pi/4);
    
    distNearest = euclideanDistance(borderedImage, imgNearest);
    distLinear = euclideanDistance(borderedImage, imgLinear);

    disp('Nearest distance to original')
    disp(distNearest)
    disp('Linear distance to original')
    disp(distLinear)
    
    % At first it is not what we expect, since nearest neighbour has less
    % distance to the original image then linear. However, this makes more
    % sense if we realise that linear will always guess somewhere in the
    % middle of the value. Meaning it will be off a little more with
    % distance but for the image as a whole will be better.
   
    %% Question 4.1.1 / 4.1.3
    % Check out the implementation of
    % myAffine(image, x1, y1, x2, y2, x3, y3, m, n, method)
    
    %% Question 4.1.2
    [~, ~, topMargin, leftMargin] = imageRotationMargins(img, pi/4);
    [height, width] = size(img);
    figure('name', 'Image after affine transformation')
    rotatedImage = myAffine(img, -topMargin, width/2, height/2, ...
                   -leftMargin, height/2, width+leftMargin, height, width, 'linear');
    imshow(rotatedImage)
    
    %% Question 5.1.1
    % Check out the implementation of
    % createProjectionMatrix(xy, uv)

    %% Question 5.1.2 / 5.1.4
    % Check out the implementation of
    % myProjection(image, x1, y1, x2, y2, x3, y3, x4, y4, m, n, method)
    
    %% Question 5.1.3
    flyers = im2double(imread('attachments/flyers.png'));
    %figure('name', 'Unstraightened flyers');
%     imshow(flyers)
%     [x, y] = ginput(4)
    x = [571.0000 356.5000 592.0000 817.0000];
    y = [190.2500 551.7500 583.2500 172.2500];
    
    figure('name', 'Frontal view of flyer');
    transformedFlyers = myProjection(flyers, x(1), y(1), ...
             x(2), y(2), x(3), y(3), x(4), y(4), 300, ...
             400, 'linear');
    imshow(transformedFlyers)
    
    %% Question 7.1.1 / 7.1.2
    % Check out the implementation of estimateProjectionMatrix(xy, XYZ)
    
    %% Question 8.1.1
    load calibrationpoints.mat
    figure('name', '3D cubes at callibrationpoints')
    M = estimateProjectionMatrix(xy, XYZ);
    imshow('attachments/calibrationpoints.jpg')
    drawCubes(M);
    
    %% Question 8.1.2
    XYZ = [0 5 5
           0 3 5
           0 1 5
           1 0 5
           3 0 5
           5 0 5
           0 5 3
           0 3 3
           0 1 3];
       
    % View 1
    figure('name', 'Cubes on view 1')
    imshow('attachments/view1.jpg');
    %xy = ginput(9)
    xy = [189.0000  345.0000
          225.0000  351.0000
          263.0000  356.0000
          301.0000  356.0000
          333.0000  350.0000
          363.0000  343.0000
          191.0000  396.0000
          225.0000  400.0000
          264.0000  407.0000];
    M = estimateProjectionMatrix(xy, XYZ);
    drawCubes(M);
    
    % View 2
    figure('name', 'Cubes on view 2')
    imshow('attachments/view2.jpg');
    %xy = ginput(9)
    xy = [142.0000  350.0000
          175.0000  354.0000
          211.0000  358.0000
          250.0000  356.0000
          286.0000  348.0000
          318.0000  341.0000
          145.0000  399.0000
          178.0000  404.0000
          215.0000  409.0000];
    M = estimateProjectionMatrix(xy, XYZ);
    drawCubes(M);
    
    % View 3
    figure('name', 'Cubes on view 3')
    imshow('attachments/view3.jpg');
    %xy = ginput(9)
    xy = [190.0000  351.0000
          220.0000  355.0000
          253.0000  360.0000
          292.0000  359.0000
          330.0000  353.0000
          366.0000  346.0000
          192.0000  399.0000
          222.0000  405.0000
          255.0000  412.0000];
    M = estimateProjectionMatrix(xy, XYZ);
    drawCubes(M);
    
    % View 4
    figure('name', 'Cubes on view 4')
    imshow('attachments/view4.jpg');
    %xy = ginput(9)
    xy = [136   358
          164   362
          193   367
          232   366
          275   357
          313   350
          139   407
          167   413
          196   418];
    M = estimateProjectionMatrix(xy, XYZ);
    drawCubes(M);
end