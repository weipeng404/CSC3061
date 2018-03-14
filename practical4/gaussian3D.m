clear all
close all

%pixel value
x = [75 160 30]

%Gaussian
nu = [50 60 100]
Sigma = [800 20 30; 10 780 20; 30 40 670]

%Calculate the probaibility
% 1st calculate the inverse of the covariance matrix
InvSigma = inv(Sigma)
DetSigma = det(Sigma)

NormalizationFactor = 1/(((2*pi)^(3/2))*(DetSigma^(1/2)))
MahalanobisDistance = (x-nu)*InvSigma*(x-nu)'

p= NormalizationFactor * exp(-MahalanobisDistance/2)