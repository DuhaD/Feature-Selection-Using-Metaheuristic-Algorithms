
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Data is NOT normalized 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [training_stat,testing_stat,train_time,test_time] = DT(training,training_labels,testing, testing_labels)
tic(); 
% Train the classifier
TREEModel = fitctree(training,training_labels);%, 'MinLeafSize', 50, 'MaxNumSplits',10); 

% save('tree.mat','TREEModel');
% view(TREEModel, 'mode', 'graph');
% % export(TREEModel, 'file', 'tree.pdf');

%%%%%% Training %%%%%%
% Predict training labels
predictions = predict(TREEModel, training);

train_time = toc;
% Compute the statistics
training_stat = confusionmatStats(training_labels,predictions);

%%%%%% Testing %%%%%%
% Predict testing labels
tic(); 
predictions = predict(TREEModel,testing);
% Compute the statistics
test_time = toc;
testing_stat = confusionmatStats(testing_labels,predictions);
end


