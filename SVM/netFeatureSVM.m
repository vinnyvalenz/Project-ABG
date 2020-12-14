function [] = netFeatureSVM()
    
    % Vector of network names to use and one for loading
    [dir, net, network, layers, seeds] = svm_variables();
    
    % Create directories for saved data
    if ~exist("svm_data_"+network, 'dir')
       mkdir("svm_data_"+network)
       mkdir("svm_data_"+network+"/t1")
       mkdir("svm_data_"+network+"/t2")
       mkdir("svm_data_"+network+"/t3")
       mkdir("svm_data_"+network+"/features")
       mkdir("svm_data_"+network+"/datastore")
    end
    
    hgstAcc = 0;
    lwstAcc = 1;
    hgstSvm = "";
    lwstSvm = "";
    
    for s=1:size(seeds,2)
        
        data_name = "svm_data_"+network+"/datastore/"+network+"_DS_s"+num2str(seeds(s));
        [training_Set, validation_Set, testing_Set] = getOriginalDataSplits(dir,seeds(s),data_name);
        
%         % Uncomment for OVER SAMPLING training set
%         training_Set = OverSampleTrainingSet(training_Set);
%         % Re-save the datastore
%         save(data_name, 'training_Set','validation_Set','testing_Set');

        for l=1:size(layers,2)
            [acc svm] = getSvms(net,network,layers(l),seeds(s));
            
            if hgstAcc < max(acc)
                hgstAcc = max(acc);
                hgstSvm = svm(find(acc == max(acc))); 
            end 
            
            if lwstAcc > min(acc)
                lwstAcc = min(acc);
                lwstSvm = svm(find(acc == min(acc))); 
            end 
            
        end

    end 
    
    save("svm_data_"+network+"/best_performing", 'hgstAcc', 'hgstSvm');
    save("svm_data_"+network+"/worst_performing", 'lwstAcc', 'lwstSvm');
    
end

