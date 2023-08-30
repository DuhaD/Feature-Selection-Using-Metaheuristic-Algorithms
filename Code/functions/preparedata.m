function [norm_data] = preparedata(data)
    % Preprocess the data by scaling and shuffling
    [norm_data] = zscore(data);
end
