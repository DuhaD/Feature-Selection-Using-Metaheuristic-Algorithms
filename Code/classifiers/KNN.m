
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
% Data is normalized  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [training_stat,testing_stat,train_time,test_time] = KNN(training,training_labels,testing, testing_labels)
%normalize data
training = preparedata(training);
testing = preparedata(testing);

tic();
% Train the classifier
KNNModel = fitcknn(training,training_labels, 'Distance','cosine','NumNeighbors',10);

%%%%%% Training %%%%%%
% Predict training labels
predictions = predict(KNNModel, training);
train_time = toc;
% Compute the statistics
training_stat = confusionmatStats(training_labels,predictions);

%%%%%% Testing %%%%%%
% Predict testing labels
tic();
predictions = predict(KNNModel,testing);
test_time = toc;
% Compute the statistics
testing_stat = confusionmatStats(testing_labels,predictions);
end



