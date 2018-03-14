% Task 1: displaying images and histograms
dome = imread('dome256.jpg');
boat = imread('boat256.jpg');
figure(1);
subplot(2,2,1);
imshow(dome);
subplot(2,2,2);
imshow(boat);
subplot(2,2,3);
histogram(dome, 'BinLimits', [0,256], 'BinWidth',1);
subplot(2,2,4);
histogram(boat, 'BinLimits', [0,256], 'BinWidth',1);

H_dome = histogram(dome, 'BinLimits', [0,256], 'BinWidth',1);
HV_dome = H_dome.Values;

H_boat = histogram(boat, 'BinLimits', [0,256], 'BinWidth',1);
HV_boat = H_boat.Values;

h1 = myHistogram(dome); % h1 = HV_dome


% Task 2: brightness enhancement
figure(2);
subplot(2,3,2);
imshow(boat);
subplot(2,3,3);
histogram(boat, 'BinLimits', [0,256], 'BinWidth',1);
subplot(2,3,4);
plot(brightnessLUT(50));
boat_enhancedBrightness = enhanceBrightness(boat, 50);
subplot(2,3,5);
imshow(boat_enhancedBrightness);
subplot(2,3,6);
histogram(boat_enhancedBrightness, 'BinLimits', [0,256], 'BinWidth', 1);


% Task 3: contrast enhancement using linear streching
figure(3);
subplot(3,3,2);
imshow(boat);
subplot(3,3,3);
histogram(boat, 'BinLimits', [0,256], 'BinWidth',1);
subplot(3,3,4);
plot(contrast_LS_LUT(1.5,50));
boat_enhancedContrastLS = enhanceContrastLS(boat,1.5,50);
subplot(3,3,5);
imshow(boat_enhancedContrastLS);
subplot(3,3,6);
histogram(boat_enhancedContrastLS, 'BinLimits', [0,256], 'BinWidth',1);
subplot(3,3,7);
[boat_enhancedContrastALS, Lut] = enhanceContrastALS(boat);
plot(Lut);
subplot(3,3,8);
imshow(boat_enhancedContrastALS);
subplot(3,3,9);
histogram(boat_enhancedContrastALS, 'BinLimits', [0,256], 'BinWidth',1);

% Task 4 contrast enhancement using power law
figure(4);
subplot(4,3,2);
imshow(boat);
subplot(4,3,3);
histogram(boat, 'BinLimits', [0,256], 'BinWidth',1);
subplot(4,3,4);
plot(contrast_PL_LUT(0.5));
subplot(4,3,5);
boat_enhancedContrastPL1 = enhanceContrastPL(boat, 0.5);
imshow(boat_enhancedContrastPL1);
subplot(4,3,6);
histogram(boat_enhancedContrastPL1, 'BinLimits', [0,256], 'BinWidth',1);
subplot(4,3,7);
plot(contrast_PL_LUT(2));
subplot(4,3,8);
boat_enhancedContrastPL2 = enhanceContrastPL(boat, 2);
imshow(boat_enhancedContrastPL2);
subplot(4,3,9);
histogram(boat_enhancedContrastPL2, 'BinLimits', [0,256], 'BinWidth',1);
subplot(4,3,10);
plot(contrast_PL_LUT(3));
subplot(4,3,11);
boat_enhancedContrastPL3 = enhanceContrastPL(boat, 3);
imshow(boat_enhancedContrastPL3);
subplot(4,3,12);
histogram(boat_enhancedContrastPL3, 'BinLimits', [0,256], 'BinWidth',1);

% replace the enhanceContrastLS and enhanceContrastPL by a single
% instructions
figure(5);
subplot(3,2,1);
imshow(boat);
subplot(3,2,2);
histogram(boat, 'BinLimits', [0,256], 'BinWidth',1);
subplot(3,2,3);
boat_enhancedContrastLS_s = boat*1.5 + 50;
imshow(boat_enhancedContrastLS_s);
subplot(3,2,4);
histogram(boat_enhancedContrastLS_s, 'BinLimits', [0,256], 'BinWidth',1);
subplot(3,2,5);
boat_enhancedContrastPL_s = (double(boat).^0.5) .* (1/(255^(0.5-1)));
imagesc(boat_enhancedContrastPL_s);
subplot(3,2,6);
histogram(boat_enhancedContrastPL_s, 'BinLimits', [0,256], 'BinWidth',1);

% Task 5 contrast enhancement using histogram equalisation
figure(6);
subplot(2,4,1);
imshow(boat);
subplot(2,4,2);
histogram(boat, 'BinLimits', [0,256], 'BinWidth',1);
subplot(2,4,5);
boat_enhancedContrastHE_s = histeq(boat);
imshow(boat_enhancedContrastHE_s);
subplot(2,4,6);
histogram(boat_enhancedContrastHE_s, 'BinLimits', [0,256], 'BinWidth',1);
subplot(2,4,3);
imshow(dome);
subplot(2,4,4);
histogram(dome, 'BinLimits', [0,256], 'BinWidth',1);
subplot(2,4,7);
dome_enhancedContrastHE_s = histeq(dome);
imshow(dome_enhancedContrastHE_s);
subplot(2,4,8);
histogram(dome_enhancedContrastHE_s, 'BinLimits', [0,256], 'BinWidth',1);

figure(7); 
subplot(1,2,1);
boat_enhancedContrastHE = enhanceContrastHE(boat);
imshow(boat_enhancedContrastHE);
subplot(1,2,2);
histogram(boat_enhancedContrastHE, 'BinLimits', [0,256], 'BinWidth',1);