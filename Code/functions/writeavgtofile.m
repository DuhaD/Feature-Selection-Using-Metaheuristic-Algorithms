function [] = writeavgtofile(subfolder,selectiontype,algo, i,avgvaltrain,avgvaltest)
%benigne 0 positive
%malware 1 negative
datasetheaders = {'Algorithm', 'Accuracy','Precision Postive','Recall Positive' ,'F-Score Positive','Specificity Positive', 'Precision Negative','Recall Negative' ,'F-Score Negative','Specificity Negative' , 'Time Seconds'};

NameTR = strcat('D',num2str(i),'/',subfolder,'/',selectiontype,'_', 'D',num2str(i), '_Training_Avg');
NameTS = strcat('D',num2str(i),'/',subfolder,'/',selectiontype,'_', 'D',num2str(i), '_Testing_Avg');


% create a table with some sample data
training_data = table({algo},round(avgvaltrain(1),2),round(avgvaltrain(2),2),round(avgvaltrain(3),2),round(avgvaltrain(4),2),round(avgvaltrain(5),2),round(avgvaltrain(6),2),round(avgvaltrain(7),2),round(avgvaltrain(8),2),round(avgvaltrain(9),2),round(avgvaltrain(10),3), 'VariableNames', datasetheaders  );
testing_data = table({algo},round(avgvaltest(1),2),round(avgvaltest(2),2),round(avgvaltest(3),2),round(avgvaltest(4),2),round(avgvaltest(5),2),round(avgvaltest(6),2),round(avgvaltest(7),2),round(avgvaltest(8),2),round(avgvaltest(9),2),round(avgvaltest(10),3), 'VariableNames', datasetheaders  );


folderName = strcat('Results/D',num2str(i),'/',subfolder); % Change this to the name of the folder you want to create
if ~exist(folderName, 'dir')
    mkdir(folderName);
end

% append the data to the CSV file
writetable(training_data, strcat('Results/',NameTR,'.csv'), 'WriteMode', 'append');
writetable(testing_data, strcat('Results/',NameTS,'.csv'), 'WriteMode', 'append');
end

