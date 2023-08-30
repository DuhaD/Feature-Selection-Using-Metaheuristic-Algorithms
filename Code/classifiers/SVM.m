
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fitcsvm trains or cross-validates a support vector machine (SVM) model
% for one-class and two-class (binary) classification on a low-dimensional
% or moderate-dimensional predictor data set.
% SVM with Linear kernel, default for two-class learning
% Data is normalized 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [training_stat,testing_stat,train_time,test_time] = SVM(training,training_labels,testing, testing_labels)

%normalize data
training = preparedata(training);
testing = preparedata(testing);
tic();
% Train the classifier
SVMModel = fitcsvm(training,training_labels);

%%%%%% Training %%%%%%
% Predict training labels
predictions = predict(SVMModel, training);
train_time = toc;
% Compute the statistics
training_stat = confusionmatStats(training_labels,predictions);

%%%%%% Testing %%%%%%
% Predict testing labels
tic();
predictions = predict(SVMModel,testing);
test_time = toc;
% Compute the statistics
testing_stat = confusionmatStats(testing_labels,predictions);
end


