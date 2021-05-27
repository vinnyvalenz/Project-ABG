function [ training_Set , testing_Set] = getBioDataSplits(directoryName, seed, dataSplit) 
%  GETDATASPLITS Creates data splits to return to main.m
% pre_rq: That file name is the actual location of the AGBO data, this
% direction must contain the orginal data
% Para: fileName = This will take the path of the AGBO directory
% returns: will fill trainingSet, validationSet , testingSet will the right
% amount of pngs
% MEMBERSHIP IS FIXED

 %% basic assignments
files = dataSplit.training_Set;

BBI = strings;
BIN = strings;
BAM = strings;
BMA = strings;

for i=1:length(files.Files)
    filename = files.Files(i);
    if(contains(filename, "BBI"))
        BBI(end+1) = filename;
        continue;
    elseif(contains(filename, "BIN"))
        BIN(end+1) = filename;
        continue;
    elseif(contains(filename, "BAM"))
        BAM(end+1) = filename;
        continue;
    elseif(contains(filename, "BMA"))
        BMA(end+1) = filename;
        continue;
    else
        continue;
    end
end

BBI = BBI(2:end);
BIN = BIN(2:end);
BAM = BAM(2:end);
BMA = BMA(2:end);

BBIds = imageDatastore(BBI,"LabelSource","foldernames");
BINds = imageDatastore(BIN,"LabelSource","foldernames");
BAMds = imageDatastore(BAM,"LabelSource","foldernames");
BMAds = imageDatastore(BMA,"LabelSource","foldernames");

for i=1:length(BBIds.Labels)
    BBIds.Labels(i) = "BBI";
end
for i=1:length(BINds.Labels)
    BINds.Labels(i) = "BIN";
end
for i=1:length(BAMds.Labels)
    BAMds.Labels(i) = "BAM";
end
for i=1:length(BMAds.Labels)
    BMAds.Labels(i) = "BMA";
end


training_fileBBI = BBIds.Files;
training_fileBIN = BINds.Files;
training_fileBAM = BAMds.Files;
training_fileBMA = BMAds.Files;

trainingBBI_label = BBIds.Labels;
trainingBIN_label = BINds.Labels;
trainingBAM_label = BAMds.Labels;
trainingBMA_label = BMAds.Labels;

if isempty(trainingBBI_label)
    trainingBBI_label = [];
end
if isempty(trainingBIN_label)
    trainingBIN_label = [];
end
if isempty(trainingBAM_label)
    trainingBAM_label = [];
end
if isempty(trainingBMA_label)
    trainingBMA_label = [];
end

 %% basic assignments
files = dataSplit.testing_Set;

BBI = strings;
BIN = strings;
BAM = strings;
BMA = strings;

for i=1:length(files.Files)
    filename = files.Files(i);
    if(contains(filename, "BBI"))
        BBI(end+1) = filename;
        continue;
    elseif(contains(filename, "BIN"))
        BIN(end+1) = filename;
        continue;
    elseif(contains(filename, "BAM"))
        BAM(end+1) = filename;
        continue;
    elseif(contains(filename, "BMA"))
        BMA(end+1) = filename;
        continue;
    else
        continue;
    end
end

BBI = BBI(2:end);
BIN = BIN(2:end);
BAM = BAM(2:end);
BMA = BMA(2:end);

BBIds = imageDatastore(BBI,"LabelSource","foldernames");
BINds = imageDatastore(BIN,"LabelSource","foldernames");
BAMds = imageDatastore(BAM,"LabelSource","foldernames");
BMAds = imageDatastore(BMA,"LabelSource","foldernames");

for i=1:length(BBIds.Labels)
    BBIds.Labels(i) = "BBI";
end
for i=1:length(BINds.Labels)
    BINds.Labels(i) = "BIN";
end
for i=1:length(BAMds.Labels)
    BAMds.Labels(i) = "BAM";
end
for i=1:length(BMAds.Labels)
    BMAds.Labels(i) = "BMA";
end


testing_fileBBI = BBIds.Files;
testing_fileBIN = BINds.Files;
testing_fileBAM = BAMds.Files;
testing_fileBMA = BMAds.Files;

testingBBI_label = BBIds.Labels;
testingBIN_label = BINds.Labels;
testingBAM_label = BAMds.Labels;
testingBMA_label = BMAds.Labels;

if isempty(testingBBI_label)
    testingBBI_label = [];
end
if isempty(testingBIN_label)
    testingBIN_label = [];
end
if isempty(testingBAM_label)
    testingBAM_label = [];
end
if isempty(testingBMA_label)
    testingBMA_label = [];
end


%% Create Data Stores 
training_ABGO         = [training_fileBBI; training_fileBIN; training_fileBAM; training_fileBMA];
training_Label_ABGO   = [trainingBBI_label; trainingBIN_label; trainingBAM_label; trainingBMA_label];
training_Set          = imageDatastore(training_ABGO, 'Labels', training_Label_ABGO);


testing_ABGO          = [testing_fileBBI; testing_fileBIN; testing_fileBAM; testing_fileBMA];
testing_Label_ABGO    = [testingBBI_label; testingBIN_label; testingBAM_label; testingBMA_label];
testing_Set           = imageDatastore(testing_ABGO, 'Labels', testing_Label_ABGO);
end