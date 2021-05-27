function [ training_Set, testing_Set] = getBioDataSplits(directoryName, seed, dataSplit) 
%  GETDATASPLITS Creates data splits to return to main.m
% pre_rq: That file name is the actual location of the AGBO data, this
% direction must contain the orginal data
% Para: fileName = This will take the path of the AGBO directory
% returns: will fill trainingSet, validationSet , testingSet will the right
% amount of pngs
% MEMBERSHIP IS FIXED

 %% basic assignments
files = dataSplit.training_Set;

OQU = strings;
OPI = strings;

for i=1:length(files.Files)
    filename = files.Files(i);
    if(contains(filename, "OQU"))
        OQU(end+1) = filename;
        continue;
    elseif(contains(filename, "OPI"))
        OPI(end+1) = filename;
        continue;
    else
        continue;
    end
end

OQU = OQU(2:end);
OPI = OPI(2:end);

OQUds = imageDatastore(OQU,"LabelSource","foldernames");
OPIds = imageDatastore(OPI,"LabelSource","foldernames");

for i=1:length(OQUds.Labels)
    OQUds.Labels(i) = "OQU";
end
for i=1:length(OPIds.Labels)
    OPIds.Labels(i) = "OPI";
end


training_fileOQU = OQUds.Files;
training_fileOPI = OPIds.Files;

trainingOQU_label = OQUds.Labels;
trainingOPI_label = OPIds.Labels;

if isempty(trainingOQU_label)
    trainingOQU_label = [];
end
if isempty(trainingOPI_label)
    trainingOPI_label = [];
end


 %% basic assignments
files = dataSplit.testing_Set;

OQU = strings;
OPI = strings;

for i=1:length(files.Files)
    filename = files.Files(i);
    if(contains(filename, "OQU"))
        OQU(end+1) = filename;
        continue;
    elseif(contains(filename, "OPI"))
        OPI(end+1) = filename;
        continue;
    else
        continue;
    end
end

OQU = OQU(2:end);
OPI = OPI(2:end);

OQUds = imageDatastore(OQU,"LabelSource","foldernames");
OPIds = imageDatastore(OPI,"LabelSource","foldernames");

for i=1:length(OQUds.Labels)
    OQUds.Labels(i) = "OQU";
end
for i=1:length(OPIds.Labels)
    OPIds.Labels(i) = "OPI";
end

testing_fileOQU = OQUds.Files;
testing_fileOPI = OPIds.Files;

testingOQU_label = OQUds.Labels;
testingOPI_label = OPIds.Labels;

if isempty(testingOQU_label)
    testingOQU_label = [];
end
if isempty(testingOPI_label)
    testingOPI_label = [];
end


%% Create Data Stores 
training_ABGO         = [training_fileOQU; training_fileOPI];
training_Label_ABGO   = [trainingOQU_label; trainingOPI_label];
training_Set          = imageDatastore(training_ABGO, 'Labels', training_Label_ABGO);

testing_ABGO          = [testing_fileOQU; testing_fileOPI];
testing_Label_ABGO    = [testingOQU_label; testingOPI_label];
testing_Set           = imageDatastore(testing_ABGO, 'Labels', testing_Label_ABGO);
end