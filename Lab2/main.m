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