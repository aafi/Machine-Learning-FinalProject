function centroids = k_means(X, k)
[n p] = size(X);
% Initialize centroids to K random points within X
k_idx = [4 6];
temp_centroid = X(k_idx, :);
save_centroid(1).centroid = temp_centroid;
iter = 2;
% Look through all centroids, find distance of all points from it
for num = 1:3
    for i = 1:size(k)
        dist_matrix = pdist2(temp_centroid, X, 'euclidean');
        % Assign points the closest centroid
        [mins clusters] = min(dist_matrix);
    %     pdist2(all_means, X, 'euclidean', 'Smallest', 1);
    end

    % Get mean of the class 
    for i = 1:k
        r = clusters == i;
        temp_centroid(i, :) = sum(X(r, :), 1) ./ sum(r);
    end
    save_centroid(iter).centroid = temp_centroid;
    iter = iter + 1;
end
centroids = save_centroid;
end