recreateOrginalDataSplit_fixed

param: dirName
takes the directory name, and recreates the
a data split

returns 3 image stores.

Saves image datastore to file datasplit.mat

ex:
[a, b, c] =  recreateOrginalDataSplit_fixed('pngs');
a => training set
b => validation set
c => testing set 

Assumes unix pathnames '/' hardcoded
please change to '\' in the first couple of lines if needed 


Breakdown of split:

Training has all of the remaining pngs, for each class. 
Training:
A: 1920
B: 3086
G: 1705
O: 330

We have a fixed number of pngs in validation ( 200 for each ABG and 50 for Other)
Validation:
A: 200
B: 200
G: 200
O: 50

50 pngs in testing for each class.
Testing:
A: 50
B: 50
G: 50
O: 50

membership is psudorandom and fixed in each split type for each class 
