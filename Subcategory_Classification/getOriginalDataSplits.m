function [ training_Set, validation_Set , testing_Set] = getOriginalDataSplits(directoryName, seed, dataSplitName) 
%  GETDATASPLITS Creates data splits to return to main.m
% pre_rq: That file name is the actual location of the AGBO data, this
% direction must contain the orginal data
% Para: fileName = This will take the path of the AGBO directory
% returns: will fill trainingSet, validationSet , testingSet will the right
% amount of pngs
% MEMBERSHIP IS FIXED

 %% basic assignments
 A = imageDatastore(strcat(directoryName,"/anthro"),"LabelSource","foldernames"); 
 B = imageDatastore(strcat(directoryName,"/bio")   ,"LabelSource","foldernames");
 G = imageDatastore(strcat(directoryName,"/geo")   ,"LabelSource","foldernames");
 O = imageDatastore(strcat(directoryName,"/other") ,"LabelSource","foldernames");
 
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
 
%% Repeatable Randomization
% using rng will ensure the premutation will remain the same
 [totalA, ~] = size(fileA); 
 [totalB, ~] = size(fileB);
 [totalG, ~] = size(fileG);
 [totalO, ~] = size(fileO);
 
 rng(seed);
 randomizedA_idx = (randperm(totalA))';
 
 rng(seed);
 randomizedB_idx = (randperm(totalB))';
 
 rng(seed);
 randomizedG_idx = (randperm(totalG))';
 
 rng(seed);
 randomizedO_idx = (randperm(totalO))';
 
 % Apply permutations to the file order
 randomlySortedA =  sortedA(randomizedA_idx);
 randomlySortedB =  sortedB(randomizedB_idx);
 randomlySortedG =  sortedG(randomizedG_idx);
 randomlySortedO =  sortedO(randomizedO_idx);
 % ---- 

%%% *** SPLIT CREATION ***
% create test split
testA = randomlySortedA(1:50);  %50 png 
testB = randomlySortedB(1:50);  %50 png 
testG = randomlySortedG(1:50);  %50 png 
testO = randomlySortedO(1:50);  %50 png 

% Labels
testA_label  = labelA(1:50);       
testB_label  = labelB(1:50);
testG_label  = labelG(1:50);
testO_label  = labelO(1:50);

% create Validation split for ABG
% We want 200 pngs from ABG, 50 for O
% 650 png
validationA = randomlySortedA(51:250);  %200 pngs
validationB = randomlySortedB(51:250);  %200 pngs
validationG = randomlySortedG(51:250);  %200 pngs
validationO = randomlySortedO(51:100);  %50  pngs

% Labels
validationA_label  = labelA(51:250);
validationB_label  = labelB(51:250);
validationG_label  = labelG(51:250);
validationO_label  = labelO(51:100);

% create training split 
% 7041 png
trainingA = randomlySortedA(251:end);  %1920 pngs
trainingB = randomlySortedB(251:end);  %3086 pngs
trainingG = randomlySortedG(251:end);  %1705 pngs
trainingO = randomlySortedO(101:end);  %330  pngs

% Labels
trainingA_label  = labelA(251:end);
trainingB_label  = labelB(251:end);
trainingG_label  = labelG(251:end);
trainingO_label  = labelO(101:end);
% END OF SPLIT 

%% Create Data Stores 
training_ABGO         = [trainingA; trainingB; trainingG; trainingO];
training_Label_ABGO   = [trainingA_label; trainingB_label; trainingG_label; trainingO_label];
training_Set          = imageDatastore(training_ABGO,   'Labels', training_Label_ABGO);

validation_ABGO       = [validationA; validationB; validationG; validationO];
validation_Label_ABGO = [validationA_label; validationB_label; validationG_label; validationO_label];
validation_Set        = imageDatastore(validation_ABGO, 'Labels', validation_Label_ABGO);

testing_ABGO          = [testA; testB; testG; testO];
testing_Label_ABGO    = [testA_label; testB_label; testG_label; testO_label];
testing_Set           = imageDatastore(testing_ABGO,    'Labels', testing_Label_ABGO);

save(dataSplitName, 'training_Set', 'validation_Set', 'testing_Set');
end