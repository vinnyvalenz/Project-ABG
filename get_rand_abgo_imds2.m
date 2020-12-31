function [train, test] = get_rand_abgo_imds2(fileName,seed) % fileName = path abgo subfolders

% Replicable Randomized Data 


anthro_DS = imageDatastore(fileName+"/anthro","LabelSource","foldernames"); 
bio_DS = imageDatastore(fileName+"/bio","LabelSource","foldernames");
geo_DS = imageDatastore(fileName+"/geo","LabelSource","foldernames");
other_DS = imageDatastore(fileName+"/other","LabelSource","foldernames");
 
% Seed Random Number Generator
% Set seeded rng at 10. Change value to test other randomized data sets.
rng(seed);

% Test Data: 50 from each category

files_a = sort(anthro_DS.Files);
a_perm = rand_subset(files_a,50,randperm(size(files_a,1),50));

files_b = sort(bio_DS.Files);
b_perm = rand_subset(files_b,50,randperm(size(files_b,1),50));

files_g = sort(geo_DS.Files);
g_perm = rand_subset(files_g,50,randperm(size(files_g,1),50));

files_o = sort(other_DS.Files);
o_perm = rand_subset(files_o,50,randperm(size(files_o,1),50));

ab_perm = union(a_perm, b_perm);
go_perm = union(g_perm, o_perm);
test_files = union(ab_perm, go_perm);

% Test DS
test = imageDatastore(test_files, "LabelSource","foldernames");

% Set difference of test files and previous files
new_a_files = setdiff(anthro_DS.Files,a_perm);

new_b_files = setdiff(bio_DS.Files,b_perm);

new_g_files = setdiff(geo_DS.Files,g_perm);

new_o_files = setdiff(other_DS.Files,o_perm);  

% % % Validation Data: 200 from anthro, bio and geo. 50 from other
% 
% files_a = sort(new_a_files);
% a_perm = rand_subset(files_a,200,randperm(size(files_a,1),200));
% 
% files_b = sort(new_b_files);
% b_perm = rand_subset(files_b,200,randperm(size(files_b,1),200));
% 
% files_g = sort(new_g_files);
% g_perm = rand_subset(files_g,200,randperm(size(files_g,1),200));
% 
% files_o = sort(new_o_files);
% o_perm = rand_subset(files_o,50,randperm(size(files_o,1),50));
% 
% ab_perm = union(a_perm, b_perm);
% go_perm = union(g_perm, o_perm);
% val_files = union(ab_perm, go_perm);
% 
% % Validation DS
% validate = imageDatastore(val_files, "LabelSource","foldernames");
% 
% new_a_files = setdiff(files_a,a_perm);
% 
% new_b_files = setdiff(files_b,b_perm);
% 
% new_g_files = setdiff(files_g,g_perm);
% 
% new_o_files = setdiff(files_o,o_perm);  

% Train Data: All remaining images from all categories

ab_files = union(new_a_files, new_b_files);
go_files = union(new_g_files, new_o_files);
train_files = union(ab_files, go_files);

train = imageDatastore(train_files, "LabelSource","foldernames");


%Function to create a replicable random permutation of files from an existing datastore 
    function data_store = rand_subset(files,size,perm)
        data_store = cell(size,1);
        % add files at indicies from perm into new datastore
        for i=1:size 
            data_store(i,1) = files(perm(1,i),:);
        end 
    end

end