model = init_model();

for i=1:size(X_test, 1)
    prediction_final(i,:) = make_final_prediction(model,X_test(i, :),[]);
end

