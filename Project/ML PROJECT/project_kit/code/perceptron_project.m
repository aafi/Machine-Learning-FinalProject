clear;
load ../data/city_train.mat
load ../data/city_test.mat
load ../data/word_train.mat
load ../data/word_test.mat
load ../data/bigram_train.mat
load ../data/bigram_test.mat
load ../data/price_train.mat
% addpath ./logistic_regression
X_train =[city_train word_train bigram_train];
Y_train = price_train;
X_test = [city_test word_test bigram_test];

%initialize_additional_features;

%% Run algorithm
% PERFORM PCA
X = [X_train; X_test];
x_bar = mean(X);
% X = bsxfun(@minus,X,x_bar); % center
[u,sqrt_eig,PCs] = fsvd(X,500); %.^2; %computes a simplified SVD on x to get the 6 biggest singular values,
%and their corresponding eigenvectors i.e the coeff/ bases for the new data.
% SVDS is better than SVD for sparse matrices 
score = X*PCs;
score_train = score(1:length(price_train),:);
score_test = score(length(price_train)+1:end,:);

[averaged_w err] = averaged_perceptron_train(score_train, Y_train, @update_passive_aggressive, 10);
error = sqrt(mean((Y_train - score_train * averaged_w).^2));

%  for i = 1:10
%  [averaged_w(i,:) err(i,:)] = averaged_perceptron_train(score_train, Y_train, @update_passive_aggressive, i);
%  end
