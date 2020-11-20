function [test, validate, train] = get_rand_abgo_imds(fileName) % fileName = path abgo subfolders

% Replicable Randomized Data 


anthro_DS = imageDatastore(fileName+"/anthro","LabelSource","foldernames"); 
bio_DS = imageDatastore(fileName+"/bio","LabelSource","foldernames");
geo_DS = imageDatastore(fileName+"/geo","LabelSource","foldernames");
other_DS = imageDatastore(fileName+"/other","LabelSource","foldernames");

% Seed Random Number Generator
% Set seeded rng at 10. Change value to test other randomized data sets.
rng(10);

% Test Data: 50 from each category

test =   imageDatastore(union(...
                        union(...
                        rand_subset(anthro_DS,50,randperm(size(anthro_DS.Labels,1),50)),...
                        rand_subset(bio_DS,50,randperm(size(bio_DS.Labels,1),50))...
                        ),...
                        union(...
                        rand_subset(geo_DS,50,randperm(size(geo_DS.Labels,1),50)),...
                        rand_subset(other_DS,50,randperm(size(other_DS.Labels,1),50))...
                        )...
                        ),...
                        "LabelSource","foldernames"...
                        );

files_a = test.Files(test.Labels == "anthro");
new_files = setdiff(anthro_DS.Files,files_a);
anthro_DS = imageDatastore(new_files,'LabelSource','foldernames');

files_b = test.Files(test.Labels == "bio");
new_files = setdiff(bio_DS.Files,files_b);
bio_DS = imageDatastore(new_files,'LabelSource','foldernames');

files_g = test.Files(test.Labels == "geo");
new_files = setdiff(geo_DS.Files,files_a);
geo_DS = imageDatastore(new_files,'LabelSource','foldernames');

files_o = test.Files(test.Labels == "other");
new_files = setdiff(other_DS.Files,files_o);
other_DS = imageDatastore(new_files,'LabelSource','foldernames');        
        

% Validation Data: 200 from anthro, bio and geo. 50 from other
validate = imageDatastore(union(...
                        union(...
                        rand_subset(anthro_DS, 200, randperm(size(anthro_DS.Labels,1),200)),...
                        rand_subset(bio_DS,200,randperm(size(bio_DS.Labels,1),200))...
                        ),...
                        union(...
                        rand_subset(geo_DS,200,randperm(size(geo_DS.Labels,1),200)),...
                        rand_subset(other_DS,50,randperm(size(other_DS.Labels,1),50))...
                        )...
                        ),...
                        "LabelSource","foldernames"...
                       );

files_a = validate.Files(validate.Labels == "anthro");
new_files = setdiff(anthro_DS.Files,files_a);
anthro_DS = imageDatastore(new_files,'LabelSource','foldernames');

files_b = validate.Files(validate.Labels == "bio");
new_files = setdiff(bio_DS.Files,files_b);
bio_DS = imageDatastore(new_files,'LabelSource','foldernames');

files_g = validate.Files(validate.Labels == "geo");
new_files = setdiff(geo_DS.Files,files_a);
geo_DS = imageDatastore(new_files,'LabelSource','foldernames');

files_o = validate.Files(validate.Labels == "other");
new_files = setdiff(other_DS.Files,files_o);
other_DS = imageDatastore(new_files,'LabelSource','foldernames'); 

% Train Data: All remaining images from all categories
train =  imageDatastore(union(...
                        union(anthro_DS.Files,bio_DS.Files),...
                        union(geo_DS.Files,other_DS.Files)...
                        ),...
                        "LabelSource","foldernames"...
                        );
%Function to create a replicable random permutation of files from an existing datastore 
    function data_store = rand_subset(imds,size,perm)
        data_store = cell(size,1);
        % add files at indicies from perm into new datastore
        for i=1:size 
            data_store(i,1) = imds.Files(perm(1,i),:);
        end 
    end

end