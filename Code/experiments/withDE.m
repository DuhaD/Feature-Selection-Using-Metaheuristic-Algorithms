

clear
clc

MaxIteration = 50;
AgentsNum = 30;

load features.mat
% algo_names = ['SVM','KNN', 'DT', 'ENSEMBLE'];
subfolder = "withwrapperselection";
filename = strcat('withwrapperselectionDE_',num2str(MaxIteration), '_', num2str(AgentsNum));

for i=1:8 %8 datasets
     disp('dataset '); disp(i);
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
            disp('dataset run'); disp(j);
            training_name = strcat('D',num2str(i),'/','D',num2str(i),'TR',num2str(j));
            testing_name  = strcat('D',num2str(i),'/','D',num2str(i),'TS',num2str(j));
            eval(['load ' training_name '.mat']);
            eval(['load ' testing_name '.mat']);
            
            training_data = training(:,1:end-1);
            training_label = training(:,end);
            testing_data = testing(:,1:end-1);
            testing_label = testing(:,end);
            
            dataset.nvars = size(training_data,2);
            dataset.data = training_data;
            dataset.lable = training_label;
            
%             [training_selected, testing_selected , feature_selected] = relieffSelect(30,training_data,training_label,testing_data,features(:,1:end-1));
            
             [ Best_score , generations_best, individual , initime] = DE(dataset,MaxIteration,AgentsNum);
             
                individual_01=individual>=0.5;
               individual_01=logical(individual_01);

              training_selected = training_data(:,individual_01 == 1);

              testing_selected = testing_data(:, individual_01 == 1);
              fwithoutlable = features(:,1:end-1);
              feature_selected = fwithoutlable(:, individual_01 == 1);
            
            if (algo == 1)
                [training_stat,testing_stat,train_time,test_time] = SVM(training_selected,training_label,testing_selected,testing_label);
            elseif (algo == 2)
                [training_stat,testing_stat,train_time,test_time] = KNN(training_selected,training_label,testing_selected,testing_label);
            elseif (algo == 3)
                [training_stat,testing_stat,train_time,test_time] = DT(training_selected,training_label,testing_selected,testing_label);
            elseif (algo == 4)
                [training_stat,testing_stat,train_time,test_time] = ENSEMBLE(training_selected,training_label,testing_selected,testing_label);
            end
            
            writetofile(subfolder,filename,algoname, i,j,training_stat,testing_stat,train_time,test_time);
            allvaluestraining = [allvaluestraining; [round(training_stat.accuracy(1)*100,2),round(training_stat.precision(1)*100,2),round(training_stat.recall(1)*100,2),round(training_stat.Fscore(1)*100,2),round(training_stat.specificity(1)*100,2),round(training_stat.precision(2)*100,2),round(training_stat.recall(2)*100,2),round(training_stat.Fscore(2)*100,2),round(training_stat.specificity(2)*100,2), train_time] ];
            allvaluestesting = [allvaluestesting; [round(testing_stat.accuracy(1)*100,2),round(testing_stat.precision(1)*100,2),round(testing_stat.recall(1)*100,2),round(testing_stat.Fscore(1)*100,2),round(testing_stat.specificity(1)*100,2),round(testing_stat.precision(2)*100,2),round(testing_stat.recall(2)*100,2),round(testing_stat.Fscore(2)*100,2),round(testing_stat.specificity(2)*100,2),test_time]];
            featureswritetofile(subfolder,filename,algoname, i,j,feature_selected);

        end
        
        avgvaltrain= mean(allvaluestraining);
        avgvaltest= mean(allvaluestesting);
        
        writeavgtofile(subfolder,filename,algoname, i,avgvaltrain,avgvaltest);
           
    end   
end