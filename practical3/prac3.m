% Video Processing and Motion Detection
% Task 1: Reading video files
traffic = VideoReader('viptraffic.avi');
shopping = VideoReader('shopping_center.mpg');

get(traffic)
get(shopping)

traffic_frames = read(traffic);
size(traffic_frames) % 120(height) 160(width) 3(RGB?) 120(num of frames)

implay(traffic_frames);
implay(traffic_frames, 12.5);

montage(traffic_frames);

frame_1 = traffic_frames(:,:,:,1);
figure(1), imshow(frame_1);

% Task 2: Motion detection using background subtraction
Bkg = traffic_frames(:,:,:,120);
figure(2), imshow(Bkg);

BkgGray = rgb2gray(Bkg);
size(Bkg)
size(BkgGray)

BkgGray2 = 1/3*(Bkg(:,:,1)+Bkg(:,:,2)+Bkg(:,:,3));

figure(3);
subplot(1,3,1), imshow(Bkg), title('Colour Background');
subplot(1,3,2), imshow(BkgGray), title('Gray Background');
subplot(1,3,3), imshow(BkgGray2), title('Gray Background Approx');

resultVid = VideoWriter('resultTraffic.avi');
open(resultVid);
MAP = colormap(gray(256));

figure(4);
for t = 1:120
    currentFrame = traffic_frames(:,:,:,t);
    currentFrameGray = rgb2gray(currentFrame);
    subplot(1,3,1), imshow(currentFrameGray), title(['Frame: ', num2str(t)]);
    subplot(1,3,2), imshow(BkgGray), title('Background');
    pause(0.05);
    
    BkgGray = double(BkgGray); % transfer to double for better comparison
    currentFrameGray = double(currentFrameGray);
    Blobs=abs(currentFrameGray - BkgGray) > 44; % Between frame 40-45 there is a flash. The background changes
    subplot(1,3,3), imshow(Blobs), title('Blobs'), colormap(gray);
    
    frame = im2frame(uint8(Blobs)*255, MAP);
    writeVideo(resultVid, frame);
end
close(resultVid);

% Task 2: Background update
for t = 1:20
    tic
    BkgUpdate = bckGenerator(traffic_frames, t);
    toc
    figure(5), imagesc(BkgUpdate), colormap(gray);
    pause(1.0);
end
BkgUpdate = bckGenerator(traffic_frames, 4);
% Conclusion: The bigger the sampling value, the less the computation time.
% I think when sampling value=4 is the optimal value

% Task 3: Postprocessing
Mask = ones(7,7);

figure(6);
for t = 1:120
    currentFrame = traffic_frames(:,:,:,t);
    currentFrameGray = rgb2gray(currentFrame);
    currentFrameGray = double(currentFrameGray);
    subplot(2,3,1), imagesc(currentFrameGray), colormap(gray), title(['Frame: ', num2str(t)]);
    subplot(2,3,2), imagesc(BkgUpdate), colormap(gray), title('Background Update');
    pause(0.1);
    
    BlobsUpdate=abs(currentFrameGray - BkgUpdate) > 44;
    subplot(2,3,3), imagesc(BlobsUpdate), colormap(gray), title('Blobs Update');
    
    BlobsClosed = imclose(BlobsUpdate, Mask);
    BlobsOpened = imopen(BlobsClosed, Mask);
    BlobsCorrect = BlobsOpened;
    subplot(2,3,4), imagesc(BlobsCorrect), colormap(gray), title('Postprocessed Blobs(7,7)');
    
    BlobsLabel = bwlabel(BlobsCorrect);
    subplot(2,3,5), imagesc(BlobsLabel), title('Labelling');
    
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
    
    subplot(2,3,6), imagesc(currentFrame), title('Detections'), hold on
    for b=1:NumVehicles
        rectangle('Position', [BoundingBoxes(b,1) BoundingBoxes(b,2) BoundingBoxes(b,3)-BoundingBoxes(b,1)+1 BoundingBoxes(b,4)-BoundingBoxes(b,2)+1])
    end
    hold off
end

% Task 4: New videos
shopping_frames = read(shopping);
size(shopping_frames) % 288 384 3 560

for t = 1:20
    tic
    BkgUpdate = bckGenerator(shopping_frames, t);
    toc
    figure(7), imagesc(BkgUpdate), colormap(gray);
    pause(1.0);
end
BkgUpdate = bckGenerator(shopping_frames,4);

figure(8);
for t=1:560
    currentFrame = shopping_frames(:,:,:,t);
    currentFrameGray = rgb2gray(currentFrame);
    currentFrameGray = double(currentFrameGray);
    subplot(2,3,1), imagesc(currentFrameGray), colormap(gray), title(['Frame: ', num2str(t)]);
    subplot(2,3,2), imagesc(BkgUpdate), colormap(gray), title('Background Update');
    pause(0.001);
    
    BlobsUpdate=abs(currentFrameGray - BkgUpdate) > 30;
    subplot(2,3,3), imagesc(BlobsUpdate), colormap(gray), title('Blobs Update');
    
    BlobsClosed = imclose(BlobsUpdate, Mask);
    BlobsOpened = imopen(BlobsClosed, Mask);
    BlobsCorrect = BlobsOpened;
    subplot(2,3,4), imagesc(BlobsCorrect), colormap(gray), title('Postprocessed Blobs(7,7)');
    
    BlobsLabel = bwlabel(BlobsCorrect);
    subplot(2,3,5), imagesc(BlobsLabel), title('Labelling');
    
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
    
    subplot(2,3,6), imagesc(currentFrame), title('Detections'), hold on
    for b=1:NumVehicles
        rectangle('Position', [BoundingBoxes(b,1) BoundingBoxes(b,2) BoundingBoxes(b,3)-BoundingBoxes(b,1)+1 BoundingBoxes(b,4)-BoundingBoxes(b,2)+1])
    end
    hold off
end