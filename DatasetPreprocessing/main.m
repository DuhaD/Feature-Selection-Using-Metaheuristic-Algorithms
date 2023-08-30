clear all
clc

load('benign.mat');
load('virustotal.mat');
load('vxheaven.mat');
load('features.mat');

%%% Sum all columns column by column to find the ones that always sum to
%%% zero

sumben=(sum(benign(:,1:1084),1));
sumvr=(sum(virustotal(:,1:1084),1));
sumheav=(sum(vxheaven(:,1:1084),1));

all = [sumben',sumvr',sumheav'];

sumthree = sum(all,2);
allsum = [features(:,1:1084)',sumthree];

finalfeatures = sum(sumthree~=0,2)' ;
featurenum = sum(finalfeatures,2);


filteredbenign = [];
filteredvt = [];
filteredhev = [];
filteredfeatures = [];

%%% Remove the features that are always 0, since these features will have
%%% no effect on the classifier 

for i =1:1084
    if  finalfeatures(1,i) ==  1
        filteredbenign = [filteredbenign,benign(:,i) ];
        filteredvt = [filteredvt,virustotal(:,i)];
        filteredhev = [filteredhev, vxheaven(:,i)];
        filteredfeatures = [filteredfeatures, features(1,i)];
    end
end

%%%% Add the label column %%%
filteredbenign = [filteredbenign,benign(:,1085) ];
filteredvt = [filteredvt,virustotal(:,1085)];
filteredhev = [filteredhev, vxheaven(:,1085)];
filteredfeatures = [filteredfeatures, features(1,1085)];


%%% Save the filtered datasets %%%%%
save DatasetPreprocessing/filteredbenign.mat filteredbenign
save DatasetPreprocessing/filteredvirustotal.mat filteredvt
save DatasetPreprocessing/filteredvxheaven.mat filteredhev
save DatasetPreprocessing/filteredfeatures.mat filteredfeatures
