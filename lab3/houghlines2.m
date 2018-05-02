% Function takes an image and its Hough transform , finds the
% significant lines and draws them over the image
% This function uses dilation instead of labels
function [coords] = houghlines2(im, h, thresh)

    [rows, cols] = size(im);
    [nrho, ntheta] = size(h);

    rhomax = sqrt(rows^2 + cols^2);

    % Dilated image peak finding
    local_max = (h/max(max(h)) > thresh) & (imdilate(h, strel('disk',8)) == h);
    [max_row, max_col] = find(local_max);

    points = zeros(length(max_row), 2);
    % For every peak find the corresponding rho and theta
    for n = 1:length(max_row)
        points(n, 1) = (max_col(n)*pi)/ntheta;
        points(n, 2) = (max_row(n)*2*rhomax)/nrho - rhomax;
    end
    
    coords = zeros(length(points), 4);
    % Plot lines loop and return the homogenous coordinates
    for i = 1:length(points)
        [x1, y1, x2, y2] = thetarho2endpoints(points(i,1), points(i,2), 500, 500);
        coords(i, :) = [x1, y1, x2, y2];
        plot([coords(i, 1), coords(i, 3)], [coords(i, 2), coords(i, 4)]);
    end
end