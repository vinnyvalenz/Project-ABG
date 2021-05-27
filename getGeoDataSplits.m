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

GRA = strings;
GWC = strings;
GWG = strings;
GST = strings;
GOC = strings;


for i=1:length(files.Files)
    filename = files.Files(i);
    if(contains(filename, "GRA"))
        GRA(end+1) = filename;
        continue;
    elseif(contains(filename, "GWC"))
        GWC(end+1) = filename;
        continue;
    elseif(contains(filename, "GWG"))
        GWG(end+1) = filename;
        continue;
    elseif(contains(filename, "GST"))
        GST(end+1) = filename;
        continue;

    elseif(contains(filename, "GOC"))
        GOC(end+1) = filename;
        continue;
    else
        continue;
    end
end

GRA = GRA(2:end);
GWC = GWC(2:end);
GWG = GWG(2:end);
GST = GST(2:end);
GOC = GOC(2:end);


GRAds = imageDatastore(GRA,"LabelSource","foldernames");
GWCds = imageDatastore(GWC,"LabelSource","foldernames");
GWGds = imageDatastore(GWG,"LabelSource","foldernames");
GSTds = imageDatastore(GST,"LabelSource","foldernames");
GOCds = imageDatastore(GOC,"LabelSource","foldernames");

for i=1:length(GRAds.Labels)
    GRAds.Labels(i) = "GRA";
end
for i=1:length(GWCds.Labels)
    GWCds.Labels(i) = "GWC";
end
for i=1:length(GWGds.Labels)
    GWGds.Labels(i) = "GWG";
end
for i=1:length(GSTds.Labels)
    GSTds.Labels(i) = "GST";
end
for i=1:length(GOCds.Labels)
    GOCds.Labels(i) = "GOC";
end


training_fileGRA = GRAds.Files;
training_fileGWC = GWCds.Files;
training_fileGWG = GWGds.Files;
training_fileGST = GSTds.Files;
training_fileGOC = GOCds.Files;

trainingGRA_label = GRAds.Labels;
trainingGWC_label = GWCds.Labels;
trainingGWG_label = GWGds.Labels;
trainingGST_label = GSTds.Labels;
trainingGOC_label = GOCds.Labels;

if isempty(trainingGRA_label)
    trainingGRA_label = [];
end
if isempty(trainingGWC_label)
    trainingGWC_label = [];
end
if isempty(trainingGWG_label)
    trainingGWG_label = [];
end
if isempty(trainingGST_label)
    trainingGST_label = [];
end
if isempty(trainingGOC_label)
    trainingGOC_label = [];
end



 %% basic assignments
files = dataSplit.testing_Set;

GRA = strings;
GWC = strings;
GWG = strings;
GST = strings;
GOC = strings;

for i=1:length(files.Files)
    filename = files.Files(i);
    if(contains(filename, "GRA"))
        GRA(end+1) = filename;
        continue;
    elseif(contains(filename, "GWC"))
        GWC(end+1) = filename;
        continue;
    elseif(contains(filename, "GWG"))
        GWG(end+1) = filename;
        continue;
    elseif(contains(filename, "GST"))
        GST(end+1) = filename;
        continue;
    elseif(contains(filename, "GOC"))
        GOC(end+1) = filename;
        continue;
    elseif(contains(filename, "WRONGG"))

        continue;
    end
end

GRA = GRA(2:end);
GWC = GWC(2:end);
GWG = GWG(2:end);
GST = GST(2:end);
GOC = GOC(2:end);

GRAds = imageDatastore(GRA,"LabelSource","foldernames");
GWCds = imageDatastore(GWC,"LabelSource","foldernames");
GWGds = imageDatastore(GWG,"LabelSource","foldernames");
GSTds = imageDatastore(GST,"LabelSource","foldernames");
GOCds = imageDatastore(GOC,"LabelSource","foldernames");

for i=1:length(GRAds.Labels)
    GRAds.Labels(i) = "GRA";
end
for i=1:length(GWCds.Labels)
    GWCds.Labels(i) = "GWC";
end
for i=1:length(GWGds.Labels)
    GWGds.Labels(i) = "GWG";
end
for i=1:length(GSTds.Labels)
    GSTds.Labels(i) = "GST";
end
for i=1:length(GOCds.Labels)
    GOCds.Labels(i) = "GOC";
end


testing_fileGRA = GRAds.Files;
testing_fileGWC = GWCds.Files;
testing_fileGWG = GWGds.Files;
testing_fileGST = GSTds.Files;
testing_fileGOC = GOCds.Files;

testingGRA_label = GRAds.Labels;
testingGWC_label = GWCds.Labels;
testingGWG_label = GWGds.Labels;
testingGST_label = GSTds.Labels;
testingGOC_label = GOCds.Labels;

if isempty(testingGRA_label)
    testingGRA_label = [];
end
if isempty(testingGWC_label)
    testingGWC_label = [];
end
if isempty(testingGWG_label)
    testingGWG_label = [];
end
if isempty(testingGST_label)
    testingGST_label = [];
end
if isempty(testingGOC_label)
    testingGOC_label = [];
end


%% Create Data Stores 
training_ABGO         = [training_fileGRA; training_fileGWC; training_fileGWG; training_fileGST; training_fileGOC];
training_Label_ABGO   = [trainingGRA_label; trainingGWC_label; trainingGWG_label; trainingGST_label; trainingGOC_label];
training_Set          = imageDatastore(training_ABGO, 'Labels', training_Label_ABGO);

testing_ABGO          = [testing_fileGRA; testing_fileGWC; testing_fileGWG; testing_fileGST; testing_fileGOC];
testing_Label_ABGO    = [testingGRA_label; testingGWC_label; testingGWG_label; testingGST_label; testingGOC_label];
testing_Set           = imageDatastore(testing_ABGO, 'Labels', testing_Label_ABGO);
end