
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mdl = fitcnb(X,Y) returns a multiclass naive Bayes model (Mdl),
% trained by predictors X and class labels Y.
% Data is NOT normalized 
% Mdl = fitcensemble(Tbl,ResponseVarName) 
% returns the trained classification ensemble model object (Mdl)
% that contains the results of boosting 100 classification trees 
% and the predictor and response data in the table Tbl. 
% ResponseVarName is the name of the response variable in Tbl.
% By default, fitcensemble uses LogitBoost for binary classification 
% and AdaBoostM2 for multiclass classification
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [training_stat,testing_stat,train_time,test_time] = ENSEMBLE(training,training_labels,testing, testing_labels)
tic(); 
% Train the classifier
ENModel = fitcensemble(training,training_labels);


%%%%%% Training %%%%%%
% Predict training labels
predictions = predict(ENModel, training);
train_time = toc;
% Compute the statistics
training_stat = confusionmatStats(training_labels,predictions);

%%%%%% Testing %%%%%%
% Predict testing labels
tic();
predictions = predict(ENModel,testing);
test_time = toc;
% Compute the statistics
testing_stat = confusionmatStats(testing_labels,predictions);
end


