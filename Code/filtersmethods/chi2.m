function [training_selected, testing_selected, features_selected ] = chi2(top,training,training_labels,testing,features)

[idx,scores] = fscchi2(training,training_labels); 
% Select top k features
k=top;  % best 30
selected_features = idx(1:k);
training_selected= training(:, selected_features);
testing_selected = testing(:, selected_features);
features_selected = features(:, selected_features);
 
end

