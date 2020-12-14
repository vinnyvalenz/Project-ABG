function [dir, net, network, layers, seeds] = svm_variables()
    
    % Set path to directory with data
    dir = '/home/saturn/Project-ABG/ABG_classification/data/pngs';
    
    % Enter a network
    net = alexnet;
    
    % Enter the name for saved file indentification
    network = "alexnet";
    
    % Enter layer numbers
    layers = [2 4 6 8 10 12 14 16 17 19 20 22 23];
    
    % layers = [26, 52, 69, 78, 87, 104, 113, 130, 139]; add layers minus block 4
    % alexnet layers = [3, 7, 11, 13, 15, 18, 21]; relu layers
    % resnet layers [12, 19, 28, 35, 44, 51, 60, 67]; bn and relu layers
    
    % Enter seeds to use on each layer
    seeds = [2 3];
    
    
    
end

