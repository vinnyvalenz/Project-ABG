function [accuracies, svms] = getSvms(net,network,l,seed)
    
    

    % Name of saved data
    sval = num2str(seed);
    dataName = "svm_data_"+network+"/datastore/"+network+"_DS_s"+sval;
    
    % Load saved data into variable
    data = load(dataName);
    
    % Set data needed to variables
    trainingIMDS = data.training_Set;
    testIMDS = data.testing_Set;
    
    
    %resize datastore 
    inputSize = net.Layers(1).InputSize;
    train_audIMDS = augmentedImageDatastore(inputSize, trainingIMDS);
    test_audIMDS = augmentedImageDatastore(inputSize, testIMDS);

    % layer + features
    layer = net.Layers(l).Name;
    
    if ~contains(layer, 'pool')
   
        featuresTrain = activations(net,train_audIMDS,layer,'ExecutionEnvironment',"auto");
        featuresTest = activations(net,test_audIMDS,layer,'ExecutionEnvironment',"auto");
        whos featuresTrain

        featuresTrain = squeeze(mean(featuresTrain,[1 2]))';
        featuresTest = squeeze(mean(featuresTest,[1 2]))';
        whos featuresTrain
    else
        featuresTrain = activations(net,train_audIMDS,layer,'ExecutionEnvironment',"auto","OutputAs","rows");
        featuresTest = activations(net,test_audIMDS,layer,'ExecutionEnvironment',"auto","OutputAs","rows");
        whos featuresTrain
    end
    
% SVM templates 
       
    t1 = templateSVM( ...
        "BoxConstraint",1.4842,...
        'KernelScale',31.659,...
         'KernelFunction','polynomial', ...
         'PolynomialOrder',2, ...
         'Standardize',true ...
         );
     
    t2 = templateSVM( ...
        'BoxConstraint',2.1862,...
        'KernelScale','auto',...
         'Standardize',false, ...
         'KernelFunction','rbf' ...
         );

    t3 = templateSVM( ...
        'BoxConstraint',2.1731,...
        'KernelScale','auto',...
         'Standardize',false, ...
         'KernelFunction','gaussian' ...
         );

    
    template = {t1,t2,t3};

% Classify, Predict, Confusion Matrices and F-Scores
    
    % Vars to record best performing
    accuracies = zeros(1,3);
    svms(1) = "";
    svms(2) = "";
    svms(3) = "";
   
    
    kernel = ["linear" "polynomial" "gaussian"];
    layer_name = strrep(layer,'_',' ');
    
    % Save features
    feat_name = "svm_data_"+network+"/features/features_"+network+"_"+layer_name+"_s"+sval;
    save(feat_name, 'featuresTrain', 'featuresTest');

    for n=1:size(template,2)
        classifier = fitcecoc( ...
            featuresTrain, ...
            trainingIMDS.Labels, ...
            'Learners',template(n), ...
            'Options',statset('UseParallel',true) ...
            );
    
    
    YPred = predict(classifier,featuresTest);
    accuracy = mean(YPred == testIMDS.Labels);
    
    % Displaying confusion chart
%     fig = figure;
%     fig_Position = fig.Position;
%     fig_Position(3) = fig_Position(3)*1.5;
%     fig.Position = fig_Position;
    cm = confusionchart(testIMDS.Labels,YPred,'RowSummary','row-normalized','ColumnSummary','column-normalized');
    
    t = [network+" Layer: "+layer_name,"Kernel: "+kernel(n),"Seed: "+sval];
    title(cm,t);
    
    % Calculating fScore and avg_f_score
    cm1 = cm.NormalizedValues;
    
    precision= zeros(1,size(cm1,1));
    recall = zeros(1,size(cm1,1));
    fScore = zeros(1,size(precision,2));
    
    for i = 1:size(cm1,1)
        precision(i) = cm1(i,i)/sum(cm1(i,:));
    end
    
    for i = 1:size(cm1,1)
        recall(i) = cm1(i,i)/sum(cm1(:,i));
    end
    
    for i = 1:size(precision,2)
        fScore(i) = (2 * (precision(i) * recall(i)) / (precision(i) + recall(i)));
    end
    
    % Displaying results
    accuracy
    fScore
    avg_f_score = sum(fScore)/numel(fScore)
    
    % Saving results
    tval = num2str(n);
    filename = "svm_data_"+network+"/t"+tval+"/"+"t"+tval+"_"+network+"_"+layer_name+"_s"+sval;
    cm_name = "svm_data_"+network+"/t"+tval+"/"+"t"+tval+"_cm_"+network+"_"+layer_name+"_s"+sval;
    save(filename, 'accuracy','fScore','avg_f_score');
    saveas(cm,cm_name,'png');
    
    accuracies(n) = accuracy;
    svms(n) = filename;
    
    end    

end

