function [features, selected] = featureSelection(A, k, r)
    [~, d] = size(A);
    % Compute the top-k right singular vectors of A
    [~, S, V] = fastsvd(A, k);
    
    % Compute the normalized leverage scores
    p = vecnorm(V') .^ 2 / k;
%     p = p / sum(p);

    % Randomly sample r features based on leverage score
    features = sort(datasample(1:d, r, 'Replace', true, 'Weights', p));
    
    % Select the features
    selected = A(:, features);
    
    % Rescale the resulting matrix
    selected = selected .* ((r * p(features)) .^ (-1/2));
end

