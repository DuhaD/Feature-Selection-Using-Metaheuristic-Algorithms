clear all
clc

%%%%%%%%%%%% code to combined virustotal with vxheaven, the result in combined
load benign.mat
load virustotal.mat
load vxheaven.mat
malware = vertcat(virustotal, vxheaven);  % total in C 5653*244
save DatasetsToUse/malware.mat malware
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate a list of random permutations of the row indices
% each time we run this code we will have a different shuffel 
shuffel = randperm(size(malware,1));

% Reorder the rows of the matrix using the permutation list
shuffelmalware = malware(shuffel,:);

save DatasetsToUse/shuffelmalware.mat shuffelmalware

load shuffelmalware.mat

num_rows = ceil(5653 / 8);  % Number of rows in each partition 707 each

% Split the dataset into a cell array with 8 cells, each containing a smaller dataset

D1 = shuffelmalware(1:num_rows,:);
D1 = [D1;benign];
save DatasetsToUse/FinalDatasets/D1.mat D1

D2 = shuffelmalware(num_rows+1:2*num_rows,:);
D2 = [D2;benign];
save DatasetsToUse/FinalDatasets/D2.mat D2

D3 = shuffelmalware(2*num_rows+1:3*num_rows,:);
D3 = [D3;benign];
save DatasetsToUse/FinalDatasets/D3.mat D3

D4 = shuffelmalware(3*num_rows+1:4*num_rows,:);
D4 = [D4;benign];
save DatasetsToUse/FinalDatasets/D4.mat D4

D5 = shuffelmalware(4*num_rows+1:5*num_rows,:);
D5 = [D5;benign];
save DatasetsToUse/FinalDatasets/D5.mat D5

D6 = shuffelmalware(5*num_rows+1:6*num_rows,:);
D6 = [D6;benign];
save DatasetsToUse/FinalDatasets/D6.mat D6

D7 = shuffelmalware(6*num_rows+1:7*num_rows,:);
D7 = [D7;benign];
save DatasetsToUse/FinalDatasets/D7.mat D7

D8 = shuffelmalware(7*num_rows+1:end,:);
D8 = [D8;benign];
save DatasetsToUse/FinalDatasets/D8.mat D8








