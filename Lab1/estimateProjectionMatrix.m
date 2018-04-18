%% Estimate Projection Matrix
function M = estimateProjectionMatrix(xy, XYZ)

    x = xy(:, 1);
    y = xy(:, 2);
    X = XYZ(:, 1);
    Y = XYZ(:, 2);
    Z = XYZ(:, 3);
    o = ones(size(x));
    z = zeros(size(x));
    Aoddrows = [X, Y, Z, o, z, z, z, z, -X.*x, -Y.*x, -Z.*x, -x];
    Aevenrows = [z, z, z, z, X, Y, Z, o, -X.*y, -Y.*y, -Z.*y, -y];

    A = [Aoddrows; Aevenrows];
    % Do Singular Value Decomposition to obtain m
    [~, ~, V] = svd(A);
    m = V(:, end);
    % reshape m into the 3x4 projection matrix M
    M = reshape(m, 4, 3)';
end
