function [trainingSet, validationSet, testingSet] = getOverSamplingDataSplits(directoryName, percentTraining, percentValidation, seed)
%% basic assignments, get data
 A = ...
     imageDatastore(strcat(directoryName,"/anthro"), ...
     "LabelSource","foldernames"); 
 B = ...
     imageDatastore(strcat(directoryName,"/bio"),    ...
     "LabelSource","foldernames");
 G = ...
     imageDatastore(strcat(directoryName,"/geo"),    ...
     "LabelSource","foldernames");
 O = ...
     imageDatastore(strcat(directoryName,"/other"),  ...
     "LabelSource","foldernames");
 
 labelA = A.Labels;
 labelB = B.Labels;
 labelG = G.Labels;
 labelO = O.Labels;
 
 fileA = A.Files; 
 fileB = B.Files;
 fileG = G.Files;
 fileO = O.Files;
 
 %% Sort
 % Sorting will ensure that regardless of order of the files, 
 % split membership will not change
 sortedA = sort(fileA);
 sortedB = sort(fileB);
 sortedG = sort(fileG);
 sortedO = sort(fileO);
 
 sorted_ABGO_files   = [sortedA; sortedB; sortedG; sortedO];
 sorted_Labels_ABGO  = [labelA; labelB; labelG; labelO];
 
 sorted_ABGO =  ...
     imageDatastore(sorted_ABGO_files, 'Labels', sorted_Labels_ABGO);
  
%% Create Validation and Test Split
%  rng for reproducibility 
if percentValidation == 0 
    % This is added just in case we decided to creat different datasplits 
    % for feature extraction
    
   rng(seed);
   [unSampledTrainingSet, testingSet] =  ...
       splitEachLabel(sorted_ABGO, percentTraining,'randomized');
  
   validationSet = 0;
else
    
   rng(seed);
   [unSampledTrainingSet, validationSet, testingSet] =  ...
       splitEachLabel(sorted_ABGO, percentTraining, percentValidation, 'randomized');
   
end
 
%% Create TrainingSet via OverSampling
label = unSampledTrainingSet.Labels;
[G,classes] = findgroups(label);
numObservations = splitapply(@numel,label,G);

% finds majority class
desiredNumObservationsPerClass = max(numObservations);

% oversampling algo on minority class
files = splitapply(@(x){oversampling(x,desiredNumObservationsPerClass,1)},...
    unSampledTrainingSet.Files,G);

% join algo
files = vertcat(files{:});

labels =[];
info=strfind(files,'/'); % Change this if needed

% Algo by Kenta
for i=1:numel(files) % Joins the resulting oversampling
    idx=info{i};
    dirName=files{i};
    targetStr=dirName(idx(end-1)+1:idx(end)-1);
    targetStr2=cellstr(targetStr);
    labels = [labels;categorical(targetStr2)];
end

% New data store with oversampled data
unSampledTrainingSet.Files  = files;
unSampledTrainingSet.Labels = labels;

% This is the training set 
trainingSet = imageDatastore(unSampledTrainingSet.Files, 'Labels', unSampledTrainingSet.Labels);
end

function files = oversampling(files,numDesired,seed)
% Algo by Kenta
% Oversamples Data
n = numel(files);
rng(seed);
ind = randi(n,numDesired,1);
files = files(ind);
end