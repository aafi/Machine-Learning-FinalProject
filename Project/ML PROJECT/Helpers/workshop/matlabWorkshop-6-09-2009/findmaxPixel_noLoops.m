function [maxValue argmaxValue elapsed] = findmaxPixel_noLoops(imdata)
% Finds the maximum intensity pixel in an image

% Initialize loop invariants
maxValue = -inf;
argmaxValue = [0 0];

% Run search over all pixels
tic;

% Reshape image into a M*N x 3 matrix so we can compute sum efficiently
vals = reshape(imdata, size(imdata,1)*size(imdata,2), 3);

% Compute euclidean distance of each pixel
vals = sqrt(sum(vals.^2,2)); 

% Find the maximum pixel in LINEAR indexing
[maxValue argLinear] = max(vals);

% Convert linear indexing into SUBSCRIPTS (rows and columns)
[row col] = ind2sub([size(imdata,1) size(imdata,2)], argLinear);

argmaxValue = [row col];
elapsed = toc;