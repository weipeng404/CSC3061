function [eigenVectors, eigenvalues, meanX, Xpca] = PrincipalComponentAnalysis (X, ndim)
%X is a matrix conatining all the training samples 
%the dimensions of X are: number_of_Samples x number_of_features
%ndim is a variable with the number of reduced PCA dimensions we want to obtain

%calculate mean over the samples
meanX = %////////STEP 1\\\\\\\\\\\\\\\

%subtract mean to each sample
A= %////////STEP 1\\\\\\\\\\\\\\\

% calculate covariance of the previous matrix
S = %////////STEP 2\\\\\\\\\\\\\\\

% obtain eigenvalue & eigenvector
[eigenVectors,D] = eig(S);
eigenvalues = diag(D);
% sort eigenvalues in descending order
eigenvalues = eigenvalues(end:-1:1);
eigenVectors = fliplr(eigenVectors);


if nargin<2
    % if the user does not tell us how many dimensions he wants:
    % evaluate the number of principal components needed to represent 95% Total variance.
    
    eigsum = cumsum(eigenvalues);
    eigsum = eigsum / eigsum(end);
    
    index = find(eigsum >= 0.95);
    ndim = index(1);
    
end

% return only the desired number of dimensions with the higher eignvalues
% ( higher amount of information)
eigenVectors = eigenVectors(:,1:ndim);
eigenvalues = eigenvalues(1:ndim);


% dataset transformed to the pca space:
Xpca=A*eigenVectors;

end