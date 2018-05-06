% This function is an alteration of demo_mosaic. It allows for
% more than four input points, using createProjectionMatrix from lab 1.

function mosaic(xy, xaya)

    % load images
    f1 = imread('nachtwacht1.jpg');
    f2 = imread('nachtwacht2.jpg');
    
    M = createProjectionMatrix(xy', xaya');
    
    T = maketform('projective', M);
    
    [x y] = tformfwd(T,[1 size(f1,2)], [1 size(f1,1)]);

    xdata = [min(1,x(1)) max(size(f2,2),x(2))];
    ydata = [min(1,y(1)) max(size(f2,1),y(2))];
    f12 = imtransform(f1,T,'Xdata',xdata,'YData',ydata);
    f22 = imtransform(f2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
    
    imshow(max(f12,f22));