function [maxValue argmax] = findmaxDistance(points, target)
% Finds the point in POINTS closest to the point TARGET.

% Points are in N-dimensional Euclidean space
N = size(points,2);

% Each row of input is 1 point
numPoints = size(points,1);

maxValue = -inf;
argmax = 0;

% Search through each point
for p = 1:numPoints
    
    % Compute Euclidean distance between target and point p
    dist = 0
    for n = 1:N
        dist = dist + (points(p,n) - target(n))^2;
    end
    dist = sqrt(dist);

    % Check for maximum
    if (dist > maxValue)
        maxValue = dist;
        argmax = p;
    end
end

% Vectorization Hints:

% It is possible to eliminate BOTH for loops.
% Look at the documentation for the REPMAT command.

