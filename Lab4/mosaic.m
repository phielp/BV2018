function mosaic(xy, xaya)

    % load images
    f1 = imread('nachtwacht1.jpg');
    f2 = imread('nachtwacht2.jpg');
    
    M = createProjectionMatrix(xy', xaya')';
    
    % Normalise the projection matrix before maketform
    T = maketform('projective', M ./ M(3,3));
    [x y] = tformfwd(T,[1 size(f1,2)], [1 size(f1,1)]);

    xdata = [min(1,x(1)) max(size(f2,2),x(2))];
    ydata = [min(1,y(1)) max(size(f2,1),y(2))];
    f12 = imtransform(f1,T,'Xdata',xdata,'YData',ydata);
    f22 = imtransform(f2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
    
    imshow(max(f12,f22));