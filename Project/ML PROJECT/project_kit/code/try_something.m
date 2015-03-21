clear;
load ../data/city_train.mat
load ../data/city_test.mat
load ../data/word_train.mat
load ../data/word_test.mat
load ../data/bigram_train.mat
load ../data/bigram_test.mat
load ../data/price_train.mat
%addpath ./glmnet_matlab
%addpath ./liblinear
addpath ./libsvm

X =[city_train word_train bigram_train];
Y = price_train;
X_t = [city_test word_test bigram_test];



%% PERFORM PCA ON SELECTED DATA
%divide by city
tic
X_train_rev = X;
%X_train_rev(find(X_train_rev(:,1)),3) = 1;
%X_train_rev(find(X_train_rev(:,2)),4) = 1;
X_test_rev = X_t;
%X_test_rev(find(X_train_rev(:,1)),3) = 1;
%X_test_rev(find(X_train_rev(:,2)),4) = 1;

%%
for i = 1:7
    %i
    ind_train_city = find(X_train_rev(:,i));
    ind_test_city = find(X_test_rev(:,i));
    
    
    X_city_train = X_train_rev(ind_train_city,8:end);
    X_city_test = X_test_rev(ind_test_city,8:end);
        
    X_city = [X_city_train; X_city_test];

    [~,~,PCs]=fsvd(X_city,250);
    score_city = X_city*PCs;
    
    Y_city{i} = Y(ind_train_city, :);
    score_train_city{i} = score_city(1:size(ind_train_city, 1),:);
    score_test_city{i} = score_city(size(ind_train_city, 1)+1:end,:);
    
end
%% kmeans
concat_Y_test = [];
Y_hat = [];

for i=1:7
%     X_train = score_train_city{i};
%     Y_train = Y_city{i};
%     X_test = score_test_city{i};
    [X_test X_train Y_test Y_train] = make_partitions(score_train_city{i}, Y_city{i}, 0.8);
    k = 10;
%     idx = kmeans(X_train,k);
%     price_hat = zeros(length(X_test),1);
%     k_prices= zeros(length(Y_test),1);
%     ind_test_all = zeros;
%     for k=1:3
%         ind = (idx==k); %logical indicator of the k-classified entries in score
%         ind_train = ind(1:length(X_train)); %take only those indices which are for score_train
%         ind_test = ind(length(X_train)+1:end); %take only those indices which are for score_test
%     
%         score_k = score_city(ind,:);
%         score_k_train = score_city(ind_train,:);
%         score_k_test = score_city(ind_test,:);
%     
%         price_k = price_train(ind_train);
%     end
%     concat_Y_test = vertcat(concat_Y_test, Y_test);
%     Y_hat = vertcat(Y_hat, price_k);
      price_pred = knn_test(k, X_train, Y_train, X_test, 'l2');
      concat_Y_test = vertcat(concat_Y_test, Y_test);
     Y_hat = vertcat(Y_hat, price_pred);
end
rmse = sqrt(mean(abs(Y_hat - concat_Y_test).^2));
toc