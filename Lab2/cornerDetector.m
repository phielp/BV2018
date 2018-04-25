%% Corner Detector
function e = cornerDetector(image, sigma)
    Fx = gD(image, sigma, 1, 0);
    Fy = gD(image, sigma, 0, 1);
    Fxx = gD(image, sigma, 2, 0);
    Fxy = gD(image, sigma, 1, 1);
    Fyy = gD(image, sigma, 0, 2);
    Fw = sqrt(Fx .^2 + Fy .^2);
    Fvv = Fx .^2 .* Fyy - Fx .* Fy .* Fxy + Fy .^2 .* Fxx;
    copy = zeros(size(image));
    for i = 2:length(image(:,1))-1
        for j = 2:length(image(1,:))-1
            % -0.0003 chosen to be significantly smaller then zero
            if (Fw(i, j) > 0.08 && Fvv(i, j) < -0.003)
                copy(i, j) = Fw(i,j);
            end
            % 0.0003 chosen to be significantly greater then zero
            if (Fw(i, j) > 0.08 && Fvv(i, j) > 0.003)
                copy(i, j) = Fw(i, j);
            end    
        end
    end
    e = copy;
end