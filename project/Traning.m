negpath = './images/neg';
pospath = './images/pos';

[features_neg, labels_neg] = loadTraingExtract(negpath, 10);
[features_pos, labels_pos] = loadTraingExtract(pospath, 10);
features = [features_neg; features_pos];
labels = [labels_neg; labels_pos];

addpath('SVM-KM');
model = SVMtraining(features(1:200,:), labels(1:200));

% test
predictions = [];
for i=201:301
    im = features(i,:);
    pred = SVMTesting(im, model);
    predictions = [predictions; pred];
end

compare = (predictions == labels(201:301));
accuracy = sum(compare)/length(compare)