clear 
clc

load DatasetsToUse/FinalDatasets/D1.mat
load DatasetsToUse/FinalDatasets/D2.mat
load DatasetsToUse/FinalDatasets/D3.mat
load DatasetsToUse/FinalDatasets/D4.mat
load DatasetsToUse/FinalDatasets/D5.mat
load DatasetsToUse/FinalDatasets/D6.mat
load DatasetsToUse/FinalDatasets/D7.mat
load DatasetsToUse/FinalDatasets/D8.mat

% datasets = {'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8'};
%%%%%%%%%%%%
for i=1:8
    
    for j=1:10
        dataset =  eval(strcat('D',num2str(i)));
        shuffel = randperm(size(dataset,1));
        
        % Reorder the rows of the matrix using the permutation list
        shuffeldataset = dataset(shuffel,:);
        
        percent = ceil(size(dataset,1)*.8);
        training_name = strcat('D',num2str(i),'/','D',num2str(i),'TR',num2str(j));
        testing_name  = strcat('D',num2str(i),'/','D',num2str(i),'TS',num2str(j));
        
        training = shuffeldataset(1:percent,:);
        testing =  shuffeldataset(percent+1:end,:);
        
        eval(['save PrepareDatasetsTrainingTesting/' training_name '.mat training' ]);
        eval(['save PrepareDatasetsTrainingTesting/' testing_name '.mat testing' ]);

    end
    
end



