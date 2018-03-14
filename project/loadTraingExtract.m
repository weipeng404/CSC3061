function [features, labels] = loadTraingExtract(foldername, sampling)
Files=dir(foldername); % list all the folder contents
features = [];
labels = [];

if foldername == './images/neg'
    label = -1;
else
    if foldername == './images/pos'
        label = 1;
    end
end

addpath('Preprocessing');
for k=3:sampling:length(Files) % the first 2 are '.' and '..'
   filename = Files(k).name;
   
   image = imread(filename); % read the image
   
   if size(image,3)==3
       image = rgb2gray(image);
   end
   
%    Pre-processing
   image_processed = enhanceContrastHE(image); % use histogram equalisation to preprocess
   image_processed = double(image_processed);
   
   
%    Feature extraction
   feature = hog_feature_vector(image_processed); % extract the HOG feature
   features = [features; feature];
   
   labels = [labels; label];
end

end