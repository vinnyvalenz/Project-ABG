Extract features from neural network layers to classify ABGO data
using SVM templates fitted to an ECOC.

Before running you need to set parameters in svm_variables.m
	-PATH/TO/DATA
	-Neural Network
	-Layers of NN. Use layer number
	-Seeds

The script will generate the following folder and subfolders
each storing the relevant data

	-svm_data_<network>/ 
		--features/
		--datastore/
		--t1/
		--t2/
		--t3/

The templates are in templates.txt and can be modified
in getSVMs.m

If you have the parallel computing toolbox you can add the following
options in getSMVs.m
	-In activations() add 'ExecutionEnvironment','auto'
	-In fitcecoc() add 'Options',statset('UseParallel',true) 

To run:
	>> netFeaturesSVM()


 
