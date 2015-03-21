function [maxValue argmaxValue elapsed] = findmaxPixel(imdata)
% Finds the maximum intensity pixel in an image

% Initialize loop invariants
maxValue = -inf;
argmaxValue = [0 0];

% Run search over all pixels
tic;
for row = 1:size(imdata,1)
    for col = 1:size(imdata,2)
   
        % Compute intensity via Euclidean magnitude in colorspace
        val = sqrt(imdata(row,col,1)^2 + imdata(row,col,2)^2 + ...
                   imdata(row,col,3)^2);

        % Check for maximum value
        if (val > maxValue)
            maxValue = val;
            argmaxValue = [row col];
        end
        
    end
end
elapsed = toc;