%% Rotation Matrix
function A = rot(phi)

    A = [cos(phi), -sin(phi), 0;
         sin(phi), cos(phi),  0;
         0,        0,         1];
end