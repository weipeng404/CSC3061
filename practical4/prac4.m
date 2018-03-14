% MOTION DETECTION
% Task 1: GMM
addpath('Motion');
addpath('../practical3');
traffic = VideoReader('viptraffic.avi');
traffic_frames = read(traffic);
NumFrames = size(traffic_frames,4);
height = size(traffic_frames,1);
width = size(traffic_frames,2);

GMM = InitialiseGMM(height, width); % the means are initialised randomly
Mask = ones(7,7);

%? why the result is not better than before and even worse?
for t = 1:NumFrames
    currentFrame = traffic_frames(:,:,:,t);
    currentFrameGray = rgb2gray(currentFrame);
    currentFrameDouble = double(currentFrameGray);
    
    [Foreground, Background, GMM] = RunGMM(currentFrameDouble, GMM);
    figure(1);
    subplot(2,3,1), imshow(uint8(currentFrameDouble)), title(['Frame: ', num2str(t)]);
    subplot(2,3,2), imshow(uint8(Background)), title('Background');
    subplot(2,3,3), imshow(uint8(Foreground)), title('Foreground');
% 1. At the beginning, the Background Gaussian is modeled as mean=rand(1),
% sd=6, so the background is like noise image at first. Gradually the
% background becomes more clear.
% 2. At the middle of the video, because of the change of light of camera,
% most of the background changes suddenly, so most of the frame is 
% considered not belonged to the Gaussian model. That also happened in the
% previous tasks.

    Blobs = Foreground > 0;
    subplot(2,3,4), imshow(Blobs), title('Blobs');
    pause(0.005);
    
    BlobsClosed = imclose(Blobs, Mask);
    BlobsOpened = imopen(BlobsClosed, Mask);
    BlobsCorrect = BlobsOpened;
    subplot(2,3,5), imshow(BlobsCorrect), title('Postprocessed Blobs');
    
    BlobsLabel = bwlabel(BlobsCorrect);
    NumVehicles = max(max(BlobsLabel));
    BoundingBoxes = [];
    for b=1:NumVehicles
        [ys,xs] = find(BlobsLabel == b);
        xmax = max(xs);
        ymax = max(ys);
        xmin = min(xs);
        ymin = min(ys);
        BoundingBox = [xmin ymin xmax ymax];
        BoundingBoxes = [BoundingBoxes; BoundingBox];
    end
    
    subplot(2,3,6), imshow(currentFrame), title('Detections'), hold on
    for b=1:NumVehicles
        rectangle('Position', [BoundingBoxes(b,1) BoundingBoxes(b,2) BoundingBoxes(b,3)-BoundingBoxes(b,1)+1 BoundingBoxes(b,4)-BoundingBoxes(b,2)+1])
    end
    hold off
end

% Task 2: Optical flow
for t = 2:NumFrames
    currentFrame = traffic_frames(:,:,:,t);
    currentFrameGray = rgb2gray(currentFrame);
    currentFrameDouble = double(currentFrameGray);
    previousFrame = traffic_frames(:,:,:,t-1);
    previousFrameGray = rgb2gray(previousFrame);
    previousFrameDouble = double(previousFrameGray);
    
    [u, v] = HS(previousFrameDouble, currentFrameDouble);
    
%      figure(2);
%      imshow(previousFrameDouble, [0 255]), hold on
%      quiver(u, v, 4, 'color', 'b', 'linewidth', 2);
%      set(gca, 'YDir', 'reverse');
%      hold off
    
    mag = sqrt(u.^2 + v.^2);
    vel_th = 3;
    Blobs = mag >= vel_th;
    
    figure(2);
    subplot(2,2,1), imshow(currentFrame), title(['Frame: ', num2str(t)]);
    subplot(2,2,3), imshow(Blobs), title('Blobs');
    pause(0.005);
    
    BlobsClosed = imclose(Blobs, Mask);
    BlobsOpened = imopen(BlobsClosed, Mask);
    BlobsCorrect = BlobsOpened;
    subplot(2,2,4), imshow(BlobsCorrect), title('Postprocessed Blobs');
    
    BlobsLabel = bwlabel(BlobsCorrect);
    NumVehicles = max(max(BlobsLabel));
    BoundingBoxes = [];
    for b=1:NumVehicles
        [ys,xs] = find(BlobsLabel == b);
        xmax = max(xs);
        ymax = max(ys);
        xmin = min(xs);
        ymin = min(ys);
        BoundingBox = [xmin ymin xmax ymax];
        BoundingBoxes = [BoundingBoxes; BoundingBox];
    end
    
    subplot(2,2,2), imshow(currentFrame), title('Detections'), hold on
    for b=1:NumVehicles
        rectangle('Position', [BoundingBoxes(b,1) BoundingBoxes(b,2) BoundingBoxes(b,3)-BoundingBoxes(b,1)+1 BoundingBoxes(b,4)-BoundingBoxes(b,2)+1])
    end
    hold off
end
% 1. Compared with the previous motion detection, this one performs slightly better.
% 2. The potential advantage is that when there is a large and similar
% change in frame, the foreground can still be detected, as the objects are
% moving differently from the background. Besides it's much faster.
% 3. We can change the vel_th for improvement.

% Task 3: New videos
shopping = VideoReader('shopping_center.mpg');
shopping_frames = read(shopping);
NumFrames = size(shopping_frames,4);
height = size(shopping_frames,1);
width = size(shopping_frames,2);

% GMM
GMM = InitialiseGMM(height, width);
Mask = ones(7,7);

for t = 1:NumFrames
    currentFrame = shopping_frames(:,:,:,t);
    currentFrameGray = rgb2gray(currentFrame);
    currentFrameDouble = double(currentFrameGray);
    
    [Foreground, Background, GMM] = RunGMM(currentFrameDouble, GMM);
    figure(3);
    subplot(2,3,1), imshow(uint8(currentFrameDouble)), title(['Frame: ', num2str(t)]);
    subplot(2,3,2), imshow(uint8(Background)), title('Background');
    subplot(2,3,3), imshow(uint8(Foreground)), title('Foreground');

    Blobs = Foreground > 0;
    subplot(2,3,4), imshow(Blobs), title('Blobs');
    pause(0.005);
    
    BlobsClosed = imclose(Blobs, Mask);
    BlobsOpened = imopen(BlobsClosed, Mask);
    BlobsCorrect = BlobsOpened;
    subplot(2,3,5), imshow(BlobsCorrect), title('Postprocessed Blobs');
    
    BlobsLabel = bwlabel(BlobsCorrect);
    NumVehicles = max(max(BlobsLabel));
    BoundingBoxes = [];
    for b=1:NumVehicles
        [ys,xs] = find(BlobsLabel == b);
        xmax = max(xs);
        ymax = max(ys);
        xmin = min(xs);
        ymin = min(ys);
        BoundingBox = [xmin ymin xmax ymax];
        BoundingBoxes = [BoundingBoxes; BoundingBox];
    end
    
    subplot(2,3,6), imshow(currentFrame), title('Detections'), hold on
    for b=1:NumVehicles
        rectangle('Position', [BoundingBoxes(b,1) BoundingBoxes(b,2) BoundingBoxes(b,3)-BoundingBoxes(b,1)+1 BoundingBoxes(b,4)-BoundingBoxes(b,2)+1])
    end
    hold off
end
% The GMM takes much in computation and the result is not good.

% Optical flow
for t = 2:NumFrames
    currentFrame = shopping_frames(:,:,:,t);
    currentFrameGray = rgb2gray(currentFrame);
    currentFrameDouble = double(currentFrameGray);
    previousFrame = shopping_frames(:,:,:,t-1);
    previousFrameGray = rgb2gray(previousFrame);
    previousFrameDouble = double(previousFrameGray);
    
    [u, v] = HS(previousFrameDouble, currentFrameDouble);
    
    mag = sqrt(u.^2 + v.^2);
    vel_th = 5;
    Blobs = mag >= vel_th;
    
    figure(4);
    subplot(2,2,1), imshow(currentFrame), title(['Frame: ', num2str(t)]);
    subplot(2,2,3), imshow(Blobs), title('Blobs');
    pause(0.005);
    
    BlobsClosed = imclose(Blobs, Mask);
    BlobsOpened = imopen(BlobsClosed, Mask);
    BlobsCorrect = BlobsOpened;
    subplot(2,2,4), imshow(BlobsCorrect), title('Postprocessed Blobs');
    
    BlobsLabel = bwlabel(BlobsCorrect);
    NumVehicles = max(max(BlobsLabel));
    BoundingBoxes = [];
    for b=1:NumVehicles
        [ys,xs] = find(BlobsLabel == b);
        xmax = max(xs);
        ymax = max(ys);
        xmin = min(xs);
        ymin = min(ys);
        BoundingBox = [xmin ymin xmax ymax];
        BoundingBoxes = [BoundingBoxes; BoundingBox];
    end
    
    subplot(2,2,2), imshow(currentFrame), title('Detections'), hold on
    for b=1:NumVehicles
        rectangle('Position', [BoundingBoxes(b,1) BoundingBoxes(b,2) BoundingBoxes(b,3)-BoundingBoxes(b,1)+1 BoundingBoxes(b,4)-BoundingBoxes(b,2)+1])
    end
    hold off
end
% The performance of optical flow is also not good, as the people are
% moving slowly.

% Other Detections
% Task 4: Template matching
addpath('Template');

letters = imread('letters.JPG');
letter_K = imread('K.JPG');
BoundingBox = templateMatching(letters, letter_K);
figure(5);
subplot(1,3,1), imshow(letters), title('Template');
subplot(1,3,2), imshow(letter_K), title('Target');
subplot(1,3,3), imshow(letters), title('Template Matching K'), hold on
rectangle('Position', BoundingBox, 'Edgecolor','r')
hold off

letter_S = imread('S.JPG');
BoundingBox = templateMatching(letters, letter_S);
figure(6);
subplot(1,3,1), imshow(letters), title('Template');
subplot(1,3,2), imshow(letter_S), title('Target');
subplot(1,3,3),imshow(letters), title('Template Matching S'), hold on
rectangle('Position', BoundingBox, 'Edgecolor','r')
hold off

img1 = imread('image1.jpg');
img2 = imread('image2.JPG');
BoundingBox = templateMatching(img1, img2);
figure(7);
subplot(1,3,1), imshow(img1), title('Template');
subplot(1,3,2), imshow(img2), title('Target');
subplot(1,3,3), imshow(img1), title('Template Matching'), hold on
rectangle('Position', BoundingBox, 'Edgecolor','r')
hold off
% It's not working for complex template matching

N=10;
BoundingBoxes = templateMatching2(letters, letter_K, N);
figure(8);
subplot(1,3,1), imshow(letters), title('Template');
subplot(1,3,2), imshow(letter_K), title('Target');
subplot(1,3,3), imshow(letters), title('Template Matching2 K'), hold on
for b=1:N
    rectangle('Position', [BoundingBoxes(b,1) BoundingBoxes(b,2) BoundingBoxes(b,3) BoundingBoxes(b,4)], 'Edgecolor','r')
end
hold off

N=100;
BoundingBoxes = templateMatching2(img1, img2, N);
figure(8);
subplot(1,3,1), imshow(img1), title('Template');
subplot(1,3,2), imshow(img2), title('Target');
subplot(1,3,3), imshow(img1), title('Template Matching2 K'), hold on
for b=1:N
    rectangle('Position', [BoundingBoxes(b,1) BoundingBoxes(b,2) BoundingBoxes(b,3) BoundingBoxes(b,4)], 'Edgecolor','r')
end
hold off