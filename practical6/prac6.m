% Task 1: PEDESTRIAN CLASSIFICATION
addpath('images');
addpath('People - Code');
addpath('People - Code/SVM-KM');
[images, labels] = loadPedestrianDatabase('pedestrian_train.cdataset'); % load the training data

vector_example = images(1,:);
image_example = reshape(vector_example, [160,96]); % I = 160*96

feature = hog_feature_vector(image_example); % the HOG feature vector of image

figure(1);
subplot(1,2,1), imagesc(image_example), colormap(gray), title('image');
subplot(1,2,2), showHog(feature, [160 96]), title('HOG feature vector');
% the results are not obvious, but we can see some discrete contour lines

features = []; % all the features vectors of the images in the training database
for im=1:size(images,1)
    image_vector = images(im,:);
    image = reshape(image_vector, [160,96]);
    
    feature = hog_feature_vector(image);
    features = [features; feature];
end

model = SVMtraining(features, labels);

[test_images, test_labels] = loadPedestrianDatabase('pedestrian_test.cdataset'); % load the testing data