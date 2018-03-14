function K = KalmanEstimationSolution (K,measurement)

% ESTIMATION
% Gain
K.G = 
% State update
if nargin<2
   K.x = K.x_pred;
   K.C = K.C_pred;
else
   K.x = 
   % Covariance
	K.C = 
end

