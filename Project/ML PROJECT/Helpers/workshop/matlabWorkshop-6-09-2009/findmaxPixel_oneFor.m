function [maxValue argmaxValue elapsed] = findmaxPixel_oneFor(imdata)
% Finds the maximum intensity pixel in an image

% Initialize loop invariants
maxValue = -inf;
argmaxValue = [0 0];

tic;
% Search using a for loop ONLY over rows
for row = 1:size(imdata,1)
    
    % Compute euclidean intensity of a single row of pixels 
    % using matrix notation:
    vals = sqrt( sum( imdata(row,:,:).^2, 3) );

    % Find maximum over the data in this row
    [rowmax rowargmax] = max(vals);

    % Compare to global maximum
    if (rowmax > maxValue)
        maxValue = rowmax;
        argmaxValue = [row rowargmax];
    end
    
end
elapsed = toc;



