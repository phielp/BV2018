%%
% Lab 2
% Jonas van Oenen (10670947)
% Philip Bouman (10668667)

%%
% 2.1 See implementation of Gauss.m
% 2.5
F = imread('autumn.tif');
sigma = 0.1;

tic;
H = imfilter(F, Gauss(sigma), 'conv', 'replicate');
elapsedTime = toc

imshow(H);

%%
F = imread('cameraman.tif');
H = gD(F, sigma,2,2);
imshow(H, [])
 
%%
% 3.2
 
x = -100:100;
y = -100:100;
[X, Y] = meshgrid(x, y);
A = 1; B = 2; V = 6*pi/201; W= 4*pi/201;
F = A * sin(V*X) + B * cos(W*Y);
imshow(F, [], 'xData', x, 'yData', y);
 
fx = A*V * cos(V*X);
fy = -B*W * sin(W*Y);
fxx = -A*V^2 * sin(V*X);
fyy = -B*W^2 * cos(W*Y);
fxy = 0;
 
imshow(fx, [], 'xData', x, 'yData', y);
imshow(fy, [], 'xData', x, 'yData', y);
 
%%
% 3.3
 
xx = -100:10:100;
yy = -100:10:100;
[XX, YY] = meshgrid(xx, yy);
Fx =  A * V * cos(V * XX);
Fy = -B * W * sin(W * YY);
imshow(F, [], 'xData', x, 'yData', y);
hold on;
quiver(xx, yy, Fx, Fy, 'r');
hold off;
 
%%
% 3.4
Gx = gD(F, 1, 1, 0);
Gy = gD(F, 1, 0, 1);
 
sub_Gx = Gx(xx +101, yy +101);
sub_Gy = Gy(xx +101, yy +101);
 
imshow(F, [], 'xData', x, 'yData', y);
hold on;
quiver(xx, yy, sub_Gx, sub_Gy, 'r');
hold off;