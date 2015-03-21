% University of Pennsylvania, Undergraduate Research Program
% Matlab Workshop, 6/9/2007
%
% Part II - Advanced Topics


%% Standard Programming Constructs

% "For Each" loops
for i = 1:10
    i
end

values = [1 2 8 16 32];
for i = values
    i
end

% "While" loops
x = randn(100,1);
row = 1;
while x(row) < 1   % Find the first value less than 1
    row = row + 1;
end
row

%% What's different in Matlab!! VECTORIZATION
% Naive implementation: finding the brightest pixel in an image

% Load the image
tortoise = double(imread('tortoise.jpg'));

% Try running naive implementation
[maxValue argmaxValue timeNested] = findmaxPixel(tortoise);

disp('Nested loop method:');
fprintf('seconds = %g, max = %g, argmax = [%d %d]\n', timeNested, ...
    maxValue, argmaxValue(1), argmaxValue(2));


%% Just one for loop
[maxValue argmaxValue timeSingle] = findmaxPixel_oneFor(tortoise);

disp('Single loop method:');
fprintf('seconds = %g, max = %g, argmax = [%d %d]\n', timeSingle, ...
    maxValue, argmaxValue(1), argmaxValue(2));

fprintf('Improvement factor: %g\n', timeNested / timeSingle);

%% Now, no for loops
[maxValue argmaxValue timeNoLoop] = findmaxPixel_noLoops(tortoise);

disp('No loop method:');
fprintf('seconds = %g, max = %g, argmax = [%d %d]\n', timeNoLoop, ...
    maxValue, argmaxValue(1), argmaxValue(2));

fprintf('Improvement factor: %g\n', timeNested / timeNoLoop);

%% Large scale test
clear all;

n = [2:2:20]*100;
for c = 1:numel(n)
    n(c)
    x = randn(1000, n(c), 3);
    [maxValue argmaxValue timeNested(c)] = findmaxPixel(x);
    [maxValue argmaxValue timeOneFor(c)] = findmaxPixel_oneFor(x);
    [maxValue argmaxValue timeNoLoop(c)] = findmaxPixel_noLoops(x);
end

bar(n, [timeNested; timeOneFor; timeNoLoop]');

