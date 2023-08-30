clear
clc

algo_names = ['SVM','KNN', 'DT', 'ENSEMBLE'];

subfolder = "withoutselection"; 
for i=1:8 %8 datasets
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
            
            training_name = strcat('D',num2str(i),'/','D',num2str(i),'TR',num2str(j));
            testing_name  = strcat('D',num2str(i),'/','D',num2str(i),'TS',num2str(j));
            eval(['load PrepareDatasetsTrainingTesting/' training_name '.mat']);
            eval(['load PrepareDatasetsTrainingTesting/' testing_name '.mat']);
            
            training_data = training(:,1:end-1);
            training_label = training(:,end);
            testing_data = testing(:,1:end-1);
            testing_label = testing(:,end);
            
            
           
            if (algo == 1)
                [training_stat,testing_stat,train_time,test_time] = SVM(training_data,training_label,testing_data,testing_label);
            elseif (algo == 2)
                [training_stat,testing_stat,train_time,test_time] = KNN(training_data,training_label,testing_data,testing_label);
            elseif (algo == 3)
                [training_stat,testing_stat,train_time,test_time] = DT(training_data,training_label,testing_data,testing_label);
            elseif (algo == 4)
                [training_stat,testing_stat,train_time,test_time] = ENSEMBLE(training_data,training_label,testing_data,testing_label);
            end
            
            writetofile(subfolder,'WithoutFeatureSelection',algoname, i,j,training_stat,testing_stat,train_time,test_time);
            allvaluestraining = [allvaluestraining; [round(training_stat.accuracy(1)*100,2),round(training_stat.precision(1)*100,2),round(training_stat.recall(1)*100,2),round(training_stat.Fscore(1)*100,2),round(training_stat.specificity(1)*100,2),round(training_stat.precision(2)*100,2),round(training_stat.recall(2)*100,2),round(training_stat.Fscore(2)*100,2),round(training_stat.specificity(2)*100,2), train_time] ];
            allvaluestesting = [allvaluestesting; [round(testing_stat.accuracy(1)*100,2),round(testing_stat.precision(1)*100,2),round(testing_stat.recall(1)*100,2),round(testing_stat.Fscore(1)*100,2),round(testing_stat.specificity(1)*100,2),round(testing_stat.precision(2)*100,2),round(testing_stat.recall(2)*100,2),round(testing_stat.Fscore(2)*100,2),round(testing_stat.specificity(2)*100,2),test_time]];
            
        end
        
        avgvaltrain= mean(allvaluestraining);
        avgvaltest= mean(allvaluestesting);
        
        writeavgtofile(subfolder,'WithoutFeatureSelection',algoname, i,avgvaltrain,avgvaltest);
           
    end   
end