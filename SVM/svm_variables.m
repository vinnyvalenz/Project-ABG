function [dir, net, network, layers, seeds] = svm_variables()
    
    % Set path to directory with data
    dir = '/home/saturn/Project-ABG/ABG_classification/data/pngs';
    
    % Enter a network
    net = mobilenetv2;
    
    % Enter the name for saved file indentification
    network = "mobilenetv2";
    
    % Enter layer numbers
    layers = [38 43 58 69 93];
    
    % Enter seeds to use on each layer
    seeds = [1 2 3];
    
    
    
end

