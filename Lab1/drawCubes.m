%% Performs creation and drawing of the cubes
function drawCubes(M)

    cube1 = createCube(1, [0,0,0]);
    cube2 = createCube(1, [0,7,6]);
    cube3 = createCube(1, [5,0,4]);
    subPlotFaces(estimateProjection(cube1, M));
    subPlotFaces(estimateProjection(cube2, M));
    subPlotFaces(estimateProjection(cube3, M));
end