%% Translation Matrix
function A = trans(t)
    
    A = [1, 0, t(1);
         0, 1, t(2);
         0, 0,   1];
end