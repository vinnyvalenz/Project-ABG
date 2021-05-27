function [ training_Set, testing_Set] = getAnthroDataSplits(directoryName, seed, dataSplit) 
%  GETDATASPLITS Creates data splits to return to main.m
% pre_rq: That file name is the actual location of the AGBO data, this
% direction must contain the orginal data
% Para: fileName = This will take the path of the AGBO directory
% returns: will fill trainingSet, validationSet , testingSet will the right
% amount of pngs
% MEMBERSHIP IS FIXED

 %% basic assignments
files = dataSplit.training_Set;

AAT = strings;
AVH = strings;
AVT = strings;
AVB = strings;
ART = strings;
ASI = strings;
AMA = strings;
AHV = strings;
AMU = strings;

for i=1:length(files.Files)
    filename = files.Files(i);
    if(contains(filename, "AAT"))
        AAT(end+1) = filename;
        continue;
    elseif(contains(filename, "AVH"))
        AVH(end+1) = filename;
        continue;
    elseif(contains(filename, "AVT"))
        AVT(end+1) = filename;
        continue;
    elseif(contains(filename, "AVB"))
        AVB(end+1) = filename;
        continue;
    elseif(contains(filename, "ART"))
        ART(end+1) = filename;
        continue;
    elseif(contains(filename, "ASI"))
        ASI(end+1) = filename;
        continue;
    elseif(contains(filename, "AMA"))
        AMA(end+1) = filename;
        continue;
    elseif(contains(filename, "AHV"))
        AHV(end+1) = filename;
        continue;
    elseif(contains(filename, "AMU"))
        AMU(end+1) = filename;
        continue;
    else
        continue;
    end
end

AAT = AAT(2:end);
AVH = AVH(2:end);
AVT = AVT(2:end);
AVB = AVB(2:end);
ART = ART(2:end);
ASI = ASI(2:end);
AMA = AMA(2:end);
AHV = AHV(2:end);
AMU = AMU(2:end);

AATds = imageDatastore(AAT,"LabelSource","foldernames");
AVHds = imageDatastore(AVH,"LabelSource","foldernames");
AVTds = imageDatastore(AVT,"LabelSource","foldernames");
AVBds = imageDatastore(AVB,"LabelSource","foldernames");
ARTds = imageDatastore(ART,"LabelSource","foldernames");
ASIds = imageDatastore(ASI,"LabelSource","foldernames");
AMAds = imageDatastore(AMA,"LabelSource","foldernames");
AHVds = imageDatastore(AHV,"LabelSource","foldernames");
AMUds = imageDatastore(AMU,"LabelSource","foldernames");

for i=1:length(AATds.Labels)
    AATds.Labels(i) = "AAT";
end
for i=1:length(AVHds.Labels)
    AVHds.Labels(i) = "AVH";
end
for i=1:length(AVTds.Labels)
    AVTds.Labels(i) = "AVT";
end
for i=1:length(AVBds.Labels)
    AVBds.Labels(i) = "AVB";
end
for i=1:length(ARTds.Labels)
    ARTds.Labels(i) = "ART";
end
for i=1:length(ASIds.Labels)
    ASIds.Labels(i) = "ASI";
end
for i=1:length(AMAds.Labels)
    AMAds.Labels(i) = "AMA";
end
for i=1:length(AHVds.Labels)
    AHVds.Labels(i) = "AHV";
end
for i=1:length(AMUds.Labels)
    AMUds.Labels(i) = "AMU";
end

training_fileAAT = AATds.Files;
training_fileAHV = AHVds.Files;
training_fileAMA = AMAds.Files;
training_fileAMU = AMUds.Files;
training_fileART = ARTds.Files;
training_fileASI = ASIds.Files;
training_fileAVB = AVBds.Files;
training_fileAVH = AVHds.Files;
training_fileAVT = AVTds.Files;

trainingAAT_label = AATds.Labels;
trainingAHV_label = AHVds.Labels;
trainingAMA_label = AMAds.Labels;
trainingAMU_label = AMUds.Labels;
trainingART_label = ARTds.Labels;
trainingASI_label = ASIds.Labels;
trainingAVB_label = AVBds.Labels;
trainingAVH_label = AVHds.Labels;
trainingAVT_label = AVTds.Labels;

if isempty(trainingAAT_label)
    trainingAAT_label = [];
end
if isempty(trainingAHV_label)
    trainingAHV_label = [];
end
if isempty(trainingAMA_label)
    trainingAMA_label = [];
end
if isempty(trainingAMU_label)
    trainingAMU_label = [];
end
if isempty(trainingART_label)
    trainingART_label = [];
end
if isempty(trainingASI_label)
    trainingASI_label = [];
end
if isempty(trainingAVB_label)
    trainingAVB_label = [];
end
if isempty(trainingAVH_label)
    trainingAVH_label = [];
end
if isempty(trainingAVT_label)
    trainingAVT_label = [];
end

%% basic assignments for testing
files = dataSplit.testing_Set

AAT = strings;
AVH = strings;
AVT = strings;
AVB = strings;
ART = strings;
ASI = strings;
AMA = strings;
AHV = strings;
AMU = strings;

for i=1:length(files.Files)
    filename = files.Files(i);
    if(contains(filename, "AAT"))
        AAT(end+1) = filename;
        continue;
    elseif(contains(filename, "AVH"))
        AVH(end+1) = filename;
        continue;
    elseif(contains(filename, "AVT"))
        AVT(end+1) = filename;
        continue;
    elseif(contains(filename, "AVB"))
        AVB(end+1) = filename;
        continue;
    elseif(contains(filename, "ART"))
        ART(end+1) = filename;
        continue;
    elseif(contains(filename, "ASI"))
        ASI(end+1) = filename;
        continue;
    elseif(contains(filename, "AMA"))
        AMA(end+1) = filename;
        continue;
    elseif(contains(filename, "AHV"))
        AHV(end+1) = filename;
        continue;
    elseif(contains(filename, "AMU"))
        AMU(end+1) = filename;
        continue;
    else
        continue;
    end
    
end

AAT = AAT(2:end);
AVH = AVH(2:end);
AVT = AVT(2:end);
AVB = AVB(2:end);
ART = ART(2:end);
ASI = ASI(2:end);
AMA = AMA(2:end);
AHV = AHV(2:end);
AMU = AMU(2:end);

AATds = imageDatastore(AAT,"LabelSource","foldernames");
AVHds = imageDatastore(AVH,"LabelSource","foldernames");
AVTds = imageDatastore(AVT,"LabelSource","foldernames");
AVBds = imageDatastore(AVB,"LabelSource","foldernames");
ARTds = imageDatastore(ART,"LabelSource","foldernames");
ASIds = imageDatastore(ASI,"LabelSource","foldernames");
AMAds = imageDatastore(AMA,"LabelSource","foldernames");
AHVds = imageDatastore(AHV,"LabelSource","foldernames");
AMUds = imageDatastore(AMU,"LabelSource","foldernames");

for i=1:length(AATds.Labels)
    AATds.Labels(i) = "AAT";
end
for i=1:length(AVHds.Labels)
    AVHds.Labels(i) = "AVH";
end
for i=1:length(AVTds.Labels)
    AVTds.Labels(i) = "AVT";
end
for i=1:length(AVBds.Labels)
    AVBds.Labels(i) = "AVB";
end
for i=1:length(ARTds.Labels)
    ARTds.Labels(i) = "ART";
end
for i=1:length(ASIds.Labels)
    ASIds.Labels(i) = "ASI";
end
for i=1:length(AMAds.Labels)
    AMAds.Labels(i) = "AMA";
end
for i=1:length(AHVds.Labels)
    AHVds.Labels(i) = "AHV";
end
for i=1:length(AMUds.Labels)
    AMUds.Labels(i) = "AMU";
end

testing_fileAAT = AATds.Files;
testing_fileAHV = AHVds.Files;
testing_fileAMA = AMAds.Files;
testing_fileAMU = AMUds.Files;
testing_fileART = ARTds.Files;
testing_fileASI = ASIds.Files;
testing_fileAVB = AVBds.Files;
testing_fileAVH = AVHds.Files;
testing_fileAVT = AVTds.Files;

testingAAT_label = AATds.Labels;
testingAHV_label = AHVds.Labels;
testingAMA_label = AMAds.Labels;
testingAMU_label = AMUds.Labels;
testingART_label = ARTds.Labels;
testingASI_label = ASIds.Labels;
testingAVB_label = AVBds.Labels;
testingAVH_label = AVHds.Labels;
testingAVT_label = AVTds.Labels;

if isempty(testingAAT_label)
    testingAAT_label = [];
end
if isempty(testingAHV_label)
    testingAHV_label = [];
end
if isempty(testingAMA_label)
    testingAMA_label = [];
end
if isempty(testingAMU_label)
    testingAMU_label = [];
end
if isempty(testingART_label)
    testingART_label = [];
end
if isempty(testingASI_label)
    testingASI_label = [];
end
if isempty(testingAVB_label)
    testingAVB_label = [];
end
if isempty(testingAVH_label)
    testingAVH_label = [];
end
if isempty(testingAVT_label)
    testingAVT_label = [];
end

%% Create Data Stores 
training_ABGO         = [training_fileAAT; training_fileAHV; training_fileAMA; training_fileAMU; training_fileART; training_fileASI; training_fileAVB; training_fileAVH; training_fileAVT];
training_Label_ABGO   = [trainingAAT_label; trainingAHV_label; trainingAMA_label; trainingAMU_label; trainingART_label; trainingASI_label; trainingAVB_label; trainingAVH_label; trainingAVT_label];
training_Set          = imageDatastore(training_ABGO, 'Labels', training_Label_ABGO);

testing_ABGO          = [testing_fileAAT; testing_fileAHV; testing_fileAMA; testing_fileAMU; testing_fileART; testing_fileASI; testing_fileAVB; testing_fileAVH; testing_fileAVT];
testing_Label_ABGO    = [testingAAT_label; testingAHV_label; testingAMA_label; testingAMU_label; testingART_label; testingASI_label; testingAVB_label; testingAVH_label; testingAVT_label];
testing_Set           = imageDatastore(testing_ABGO, 'Labels', testing_Label_ABGO);
end