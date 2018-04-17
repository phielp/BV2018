function M = estimateProjectionMatrix(xy, uvw)

    % Get the right indiceses for our projection
    x = xy(:,1);
    y = xy(:,2);
    u = uvw(:,1);
    v = uvw(:,2);
    w = uvw(:,3);
    o = ones(size(x));
    z = zeros(size(x));
    
    % Create the even and odd rows
    AoddRows = [u,v,w,o,z,z,z,z,-x.*u,-x.*v,-x.*w,-x];
    AevenRows = [z,z,z,z,u,v,w,o,-y.*u,-y.*v,-y.*w,-y];
    
    % Create matrix A
    A = [AevenRows;AoddRows];
    
    % Get the last column of our SVD
    [~,~,V] = svd(A);
    m = V(:,end);
    
    % Normalise our result
    m = m./m(end);  
    
    % Reshape matrix 
    M = reshape(m,4,3);
    M = M';
end