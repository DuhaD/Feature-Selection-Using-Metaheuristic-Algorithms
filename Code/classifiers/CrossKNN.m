
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% Data is normalized 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function accuracy = CrossKNN(training,training_labels,individual)
tic(); 
%normalize data
training = preparedata(training);

individual_01=individual>=0.5;
individual_01=logical(individual_01);

training_selected = training(:,individual_01 == 1);

% Train the classifier
KNNModel = fitcknn(training_selected,training_labels, 'Distance','cosine','NumNeighbors',10);

CVKNNModel = crossval(KNNModel,'KFold',5);
% Compute the average classification error
loss = kfoldLoss(CVKNNModel);
% Generate predictions for each fold
predictions = kfoldPredict(CVKNNModel);
% Compute the accuracy
accuracy = mean(predictions == training_labels);

time = toc;
end



