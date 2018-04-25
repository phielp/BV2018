
%% Lab 2
% Jonas van Oenen (10670947)
% Philip Bouman (10668667)

function main()

    close all
    image = im2double(imread('cameraman.tif'));

    %% Question 2.1
    % See the implementation of Gauss(sigma).
    % We believe ceil(3*sigma)=a is an appropriate radius for the kernel. 
    % Which results in a grid size of (a*2+1)x(a*2+1). This is based on 
    % the three-sigma rule. This rule states that 99.7% of the data are 
    % within 3 standard deviations of the mean.
    sigma = 0.6;
    Gauss(sigma)
    
    %% Question 2.2
    % It is expected that the result of the overall sum of 
    % the Gaussian kernel is 1. Since, the Gaussian distribution is 
    % a probability distribution, which is normalized, so the sum over
    % all values of the kernel gives a probability of 1.
    sum(sum(Gauss(0.6)))
    sum(sum(Gauss(2.5)))
    sum(sum(Gauss(3)))
    
    %% Question 2.3
    mesh(Gauss(3))
    
    %% Question 2.4
    % The physical unit of the scale parameter sigma is pixel unit.
    
    %% Question 2.5
    sigmas = 1:40;
    reps = 40;
    for i = 1:length(sigmas)
        totalRunTime = 0;
        for j = 1:reps
           totalRunTime = totalRunTime + calcTime(image, sigmas(i));
        end
        sigmas(i) = totalRunTime / reps;
    end
    figure
    plot(sigmas);
    
    %% Question 2.6
    % The order of the computational complexity seems to be quadratic.
    
    %% Question 2.7
    sigma = 3;
    consecutiveConv = conv2(Gauss(sigma), Gauss(sigma));
    imgConsecutiveConv = imfilter(image, consecutiveConv, 'conv', 'replicate');
    imgSingleConv = imfilter(image, Gauss(sigma), 'conv', 'replicate');
    imgDifference = imabsdiff(imgConsecutiveConv, imgSingleConv);
    figure
    imshow(imgDifference)
    
    %% Question 2.8
    % See the implementation of Gauss1.
    % The sum of all the values equals 1.
    sum(Gauss1(0.6))
    sum(Gauss1(3))
    
    %% Question 2.9
    % The order of computational complexity seems to be quadratic
    % using the separability property.
    sigmas = 1:40;
    reps = 40;
    for i = 1:length(sigmas)
        totalRunTime = 0;
        for j = 1:reps
           totalRunTime = totalRunTime + calcTimeSep(image, sigmas(i));
        end
        sigmas(i) = totalRunTime / reps;
    end
    figure
    plot(sigmas);
    
    %% Question 2.10
    % See the implementation of gD(image, sigma, xorder, yorder).
    figure
    F = gD(image, 1, 0, 2);
    imshow(F, []);
    figure
    F = gD(image, 5, 1, 0);
    imshow(F, []);
    
    %% Question 2.11
    % See our report
    figure
    F = gD(image, 2, 2, 2);
    imshow(F, []);
    
    %% Question 3.1
    % See report for the analytically calculated derivatives.
    % fx = AVcos(Vx)
    % fy = -BWsin(Wy)
    % fxx = -AV^{2}sin(Vx)
    % fyy = -BW^2cos(Wy)
    % fxy = 0
    
    %% Question 3.2
    clear
    
    x = -100:100;
    y = -100:100;
    [X, Y] = meshgrid(x, y);
    A = 1; B = 2; V = 6*pi/201; W = 4*pi/201; 
    F = A * sin(V*X) + B * cos(W*Y);
    imshow(F, [], 'xData', x, 'yData', y);
    
    % Calculation of the partial derivative of f
    % with respect to x.
    Fx = A*V*cos(V*X);
    figure
    imshow(Fx, [], 'xData', x, 'yData', y);
    % Calculation of the partial derivative of f
    % with respect to y.
    Fy = -B*W*sin(W*Y);
    figure
    imshow(Fy, [], 'xData', x, 'yData', y);
    
    %% Question 3.3
    xx = -100:10:100;
    yy = -100:10:100;
    [XX, YY] = meshgrid(xx, yy);
    Fx = A*V*cos(V*XX);
    Fy = -B*W*sin(W*YY);
    imshow(F, [], 'xData', x, 'yData', y);
    hold on;
    quiver(xx, yy, Fx, Fy, 'r');
    hold off;
    
    %% Question 3.4
    Gx = gD(F, 1, 1, 0);
    Gy = gD(F, 1, 0, 1);
    sub_Gx = Gx(xx + 101, yy + 101);
    sub_Gy = Gy(xx + 101, yy + 101);
    figure
    imshow(F, [], 'xData', x, 'yData', y);
    hold on;
    quiver(xx, yy, sub_Gx, sub_Gy, 'r');
    hold off;
    
    %% Question 3.5
    img = im2double(imread('cameraman.tif'));
    % rotate the image usingcode from the previous assignment
    F = rotateImage(img, degtorad(10), 'linear');
    % calculate the derivates appropriate to F
    Fx = gD(F, 1, 1, 0);
    Fy = gD(F, 1, 0, 1);
    figure
    imshow(F);
    hold on
    % draw gradient vectors inside the image
    quiver( Fx, Fy, 'r');
    
    %% Question 3.6
    % See report for the analytically calculated derivatives 
    % for fw and fww.
    
    %% Question 3.7
    % See the implementation of canny(image, sigma)
    
    %% Question 3.8
    % Use the canny edge detector on the picture cameraman.tif
    img = im2double(imread('cameraman.tif'));
    e = canny(img, 1);
    figure
    imshow(e);
    figure
    imshow(~e);
    
    %% Question 3.9
    % Use the corner detector to detect the corners in chess2.jpg
    img = im2double(imread('chess2.jpg'));
    c = cornerDetector(img, 1);
    figure
    imshow(c);
    
end