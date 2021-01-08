[trainingSet1, validationSet1,testingSet1] = ...
getOrginalDataSplits('pngs', 1, '1.mat');
OverSampleTrainingSet1 =getOverSamplingDataSplits(trainingSet1);

[trainingSet2,validationSet2,testingSet2] = ...
getOrginalDataSplits('pngs', 2, '2.mat');
OverSampleTrainingSet2 =getOverSamplingDataSplits(trainingSet2);

[trainingSet3,validationSet3,testingSet3] = ...
getOrginalDataSplits('pngs', 3, '3.mat');
OverSampleTrainingSet3 =getOverSamplingDataSplits(trainingSet3);

save('oversampleSplits.mat', 'OverSampleTrainingSet1', 'OverSampleTrainingSet2', 'OverSampleTrainingSet3');