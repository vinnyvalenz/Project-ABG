function [trainingSet] = OverSampleTrainingSet(unSampledTrainingSet)
%% Create TrainingSet via OverSampling
label = unSampledTrainingSet.Labels;

[G,classes] = findgroups(label);
numObservations = splitapply(@numel,label,G);

% finds majority class
desiredNumObservationsPerClass = max(numObservations);

% oversampling algo on minority class
files = splitapply(@(x){oversampling(x,desiredNumObservationsPerClass)},...
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

function files = oversampling(files,numDesired)
% Algo by Kenta
% Oversamples Data
n = numel(files);
rng('default');
ind = randi(n,numDesired,1);
files = files(ind);
end