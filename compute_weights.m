function [ W ] = compute_weights( X, average, Y, c )

S = compute_feature_vectors(X, average);
R = S' * S;
W = Y' * S * inv(R + c*eye(size(R)));

end
