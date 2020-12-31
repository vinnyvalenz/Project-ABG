function [dir, net, network, layers, seeds] = svm_variables()
    
    % Set path to directory with data
    dir = '/home/saturn/ABG/ABG_classification/data/pngs';
    
    % Enter a network
    net = load('hg_9s0.mat').cnnet;
    
    % Enter the name for saved file indentification
    network = "hg_9";
    
    % Enter layer numbers
    layers = [5,7,9,11,13,15,17];
    
    % mobilenet layers = [26, 52, 69, 78, 87, 104, 113, 130, 139]; add layers minus block 4
    % alexnet layers = [3, 7, 11, 13, 15, 18, 21]; relu layers
    %                   [2 4 6 8 10 12 14 16 17 19 20 22 23]; remaining
    %                   useful alexnet layers
    %                   
    % resnet layers [12, 19, 28, 35, 44, 51, 60, 67]; bn and relu layers
    
    % Enter seeds to use on each layer
    seeds = 0;
    
    
    
end

