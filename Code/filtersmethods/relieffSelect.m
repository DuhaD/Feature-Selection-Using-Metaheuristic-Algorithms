function [training_selected, testing_selected, features_selected] = relieffSelect(top,training,training_labels,testing, features)

[idx,weights] = relieff(training,training_labels,10);
k=top; %set it to 30 
selected_features = idx(1:k);
training_selected= training(:, selected_features);
testing_selected = testing(:, selected_features);
features_selected = features(:, selected_features);

end

