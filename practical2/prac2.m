% Image Enhancement using Neighbourhood Operators
% Task 1: convolution and noise filtering
boatnois = imread('boatnois.jpg');

figure(1);
subplot(1,3,1);
imshow(boatnois);
subplot(1,3,2);
mask = 1/9 * ones(3,3);
convolved_boatnois1 = conv2(boatnois,mask);
imagesc(convolved_boatnois1), colormap(gray);
convolved_boatnois2 = filter2(mask,boatnois);
subplot(1,3,3);
mask = 1/25 * ones(5,5);
convolved_boatnois3 = conv2(boatnois,mask);
imagesc(convolved_boatnois3), colormap(gray);

figure(2);
subplot(2,1,1);
c1 = noiseReduction(boatnois,5);
imagesc(c1), colormap(gray);
subplot(2,1,2);
mask = 1/25 * ones(5,5);
c2 = myconvolution(boatnois,mask);
imagesc(c2), colormap(gray);

% Task 2: neighbourhood operation for edge extraction
B1 = [-1 0 1; -1 0 1; -1 0 1];
B2 = [-1 -1 -1; 0 0 0; 1 1 1];
figure(3);
[edges, hor, ver] = edgeExtraction(boatnois, B1, B2);
subplot(2,2,1);
imagesc(boatnois), colormap(gray);
subplot(2,2,2);
imagesc(hor), colormap(gray);
subplot(2,2,3);
imagesc(ver), colormap(gray);
subplot(2,2,4);
imagesc(edges), colormap(gray);

% Preprocessing and Naive Segmentation
vehicle = imread('vehicle.jpg');
vehicle2 = imread('vehicle2.jpg');
addpath(genpath('../practical1')); % add folder into paths

figure(4);
subplot(3,2,1), imshow(vehicle), title('vehicle-1-original');
subplot(3,2,3), histogram(vehicle, 'BinLimits', [0,256], 'BinWidth',1), title('vehicle-1-original-histogram');
vehicle_enhanced = enhanceContrastALS(vehicle);
subplot(3,2,2), imshow(vehicle_enhanced), title('vehicle-1-enhanced');
subplot(3,2,4), histogram(vehicle_enhanced, 'BinLimits', [0,256], 'BinWidth',1), title('vehicle-1-enhanced-histogram');
Ibinary = vehicle_enhanced<= 75;
subplot(3,2,6), imshow(Ibinary), title('vehicle-1-segmentation');

figure(5);
subplot(3,2,1), imshow(vehicle2), title('vehicle-2-original');
subplot(3,2,3), histogram(vehicle2, 'BinLimits', [0,256], 'BinWidth',1), title('vehicle-2-original-histogram');
vehicle2_enhanced = enhanceContrastALS(vehicle2);
subplot(3,2,2), imshow(vehicle2_enhanced), title('vehicle-2-enhanced');
subplot(3,2,4), histogram(vehicle2_enhanced, 'BinLimits', [0,256], 'BinWidth',1), title('vehicle-2-enhanced-histogram');
Ibinary2 = vehicle2_enhanced<= 75;
subplot(3,2,6), imshow(Ibinary2), title('vehicle-2-segmentation');
