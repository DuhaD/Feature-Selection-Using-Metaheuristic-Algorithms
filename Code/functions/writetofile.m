function [] = writetofile(subfolder,selectiontype,algo, i,j,training_stat,testing_stat,train_time,test_time)
%benigne 0 positive
%malware 1 negative

datasetheaders = {'Dataset', 'Accuracy','Precision Postive','Recall Positive' ,'F-Score Positive','Specificity Positive', 'Precision Negative','Recall Negative' ,'F-Score Negative','Specificity Negative', 'Time Seconds' };

NameTR = strcat('D',num2str(i),'/',subfolder,'/',selectiontype,'_',algo,'_', 'D',num2str(i), '_Training');
NameTS = strcat('D',num2str(i),'/',subfolder,'/',selectiontype,'_',algo,'_', 'D',num2str(i), '_Testing');


% create a table with some sample data
training_data = table(j, round(training_stat.accuracy(1)*100,2),round(training_stat.precision(1)*100,2),round(training_stat.recall(1)*100,2),round(training_stat.Fscore(1)*100,2),round(training_stat.specificity(1)*100,2),round(training_stat.precision(2)*100,2),round(training_stat.recall(2)*100,2),round(training_stat.Fscore(2)*100,2),round(training_stat.specificity(2)*100,2), train_time, 'VariableNames', datasetheaders  );
testing_data = table(j, round(testing_stat.accuracy(1)*100,2),round(testing_stat.precision(1)*100,2),round(testing_stat.recall(1)*100,2),round(testing_stat.Fscore(1)*100,2),round(testing_stat.specificity(1)*100,2),round(testing_stat.precision(2)*100,2),round(testing_stat.recall(2)*100,2),round(testing_stat.Fscore(2)*100,2),round(testing_stat.specificity(2)*100,2), test_time, 'VariableNames', datasetheaders  );

folderName = strcat('Results/D',num2str(i),'/',subfolder); % Change this to the name of the folder you want to create
if ~exist(folderName, 'dir')
    mkdir(folderName);
end


% append the data to the CSV file
writetable(training_data, strcat('Results/',NameTR,'.csv'), 'WriteMode', 'append');
writetable(testing_data, strcat('Results/',NameTS,'.csv'), 'WriteMode', 'append');

end

