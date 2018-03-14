function [ Bkg ] = bckGenerator( videoStream, sampling )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
buffer=[];
counter=0;
for t=1:sampling:size(videoStream,4) % 1<=t<=size(), for each loop t=t+sampling
    counter = counter + 1;
    frame = videoStream(:,:,:,t);
    frameGray = rgb2gray(frame);
    frameGray = double(frameGray);
    buffer(:,:,counter) = frameGray;
end

Bkg = median(buffer,3);

end