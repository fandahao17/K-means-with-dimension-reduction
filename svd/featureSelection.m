function [features, selected] = featureSelection(A, k, r)
    [~, d] = size(A);
    % Compute the top-k right singular vectors of A
    [~, ~, V] = svd(A);
    Vk = V(:, 1:k);
    
    % Compute the normalized leverage scores
    p = vecnorm(Vk') .^ 2 / k;

    % r i.i.d sample
    features = sort(datasample(1:d, r, 'Replace', false, 'Weights', p));

    % Select
    selected = A(:, features);
    % Rescale
    selected = r ^ (-1/2) * selected .* (p(features) .^ (-1/2));
end

