clear
clc
load DatasetsToUse/benign.mat
load DatasetsToUse/malware.mat

% algo_names = ['SVM','KNN', 'DT', 'ENSEMBLE'];

fulldataset = vertcat(malware,benign);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate a list of random permutations of the row indices
% each time we run this code we will have a different shuffel
% shuffel = randperm(size(fulldataset,1));
% Reorder the rows of the matrix using the permutation list
% shuffelfulldataset = fulldataset(shuffel,:);
% 
% save DatasetsToUse/shuffelfulldataset.mat shuffelfulldataset
% 
% load shuffelfulldataset.mat

subfolder = "withoutsampling";

% Create a stratified partition of the data
cv = cvpartition(fulldataset(:,end),'KFold',10,'Stratify',true);

for algo = 1: 4 %4 algorithms
    if (algo == 1)
        algoname = 'SVM';
    elseif (algo == 2)
        algoname = 'KNN';
    elseif (algo == 3)
        algoname = 'DT';
    elseif (algo == 4)
        algoname = 'ENSEMBLE';
    end
    
    allvaluestraining = [];
    allvaluestesting = [];
    
    for j=1:10 % 10 runs for each dataset
        i=1;
       
        train_indices = cv.training(j);
        training_data = fulldataset(train_indices,1:end-1);
        training_label = fulldataset(train_indices,end);
               
        test_indices = cv.test(j);
        testing_data = fulldataset(test_indices,1:end-1);
        testing_label = fulldataset(test_indices,end);
        
        
        if (algo == 1)
            [training_stat,testing_stat,train_time,test_time] = SVM(training_data,training_label,testing_data,testing_label);
        elseif (algo == 2)
            [training_stat,testing_stat,train_time,test_time] = KNN(training_data,training_label,testing_data,testing_label);
        elseif (algo == 3)
            [training_stat,testing_stat,train_time,test_time] = DT(training_data,training_label,testing_data,testing_label);
        elseif (algo == 4)
            [training_stat,testing_stat,train_time,test_time] = ENSEMBLE(training_data,training_label,testing_data,testing_label);
        end
        
        writetofile(subfolder,'WithoutSampling',algoname, i,j,training_stat,testing_stat,train_time,test_time);
        allvaluestraining = [allvaluestraining; [round(training_stat.accuracy(1)*100,2),round(training_stat.precision(1)*100,2),round(training_stat.recall(1)*100,2),round(training_stat.Fscore(1)*100,2),round(training_stat.specificity(1)*100,2),round(training_stat.precision(2)*100,2),round(training_stat.recall(2)*100,2),round(training_stat.Fscore(2)*100,2),round(training_stat.specificity(2)*100,2), train_time] ];
        allvaluestesting = [allvaluestesting; [round(testing_stat.accuracy(1)*100,2),round(testing_stat.precision(1)*100,2),round(testing_stat.recall(1)*100,2),round(testing_stat.Fscore(1)*100,2),round(testing_stat.specificity(1)*100,2),round(testing_stat.precision(2)*100,2),round(testing_stat.recall(2)*100,2),round(testing_stat.Fscore(2)*100,2),round(testing_stat.specificity(2)*100,2),test_time]];
        
    end
    
    avgvaltrain= mean(allvaluestraining);
    avgvaltest= mean(allvaluestesting);
    
    writeavgtofile(subfolder,'WithoutSampling',algoname, i,avgvaltrain,avgvaltest);
    
end