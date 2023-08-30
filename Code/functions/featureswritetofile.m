function [] = featureswritetofile(subfolder,selectiontype,algo, i,j,features)

NameFile = strcat('D',num2str(i),'/',subfolder,'/',selectiontype,'_',algo,'_', 'D',num2str(i),'_SelectedFeatures');

str = features;
fid = fopen(strcat('Results/',NameFile,'.txt'), 'a');
fprintf(fid, '%s\t', strcat('D',num2str(i), '_', num2str(j)));
for i = 1:size(str, 2)
     fprintf(fid, '%s\t', str{:, i});
end
fprintf(fid, '\n');
fclose(fid);
end
