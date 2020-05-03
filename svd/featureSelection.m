function [selected] = featureSelection(A, k, r)
    [~, d] = size(A)
    % Compute the top-k right singular vectors of A
    [~, ~, V] = svd(A);
    Vk = V(1:k, :);
    
    % Compute the normalized leverage scores
    p = vecnorm(Vk') / k;
    
    % r i.i.d sample
    features = datasample(1:d, r, 'Replace', false, 'Weights', p);
    
    % Sampling matrix
    S = zeros(d, r);
    for i = 1 : r
        S(features(i), i) = 1;
    end
    
    % Rescaling matrix
    D = zeros(r, r);
    for i = 1 : r
        D(features(i), features(i)) = 1 / sqrt(r * p(i));
    end
    
    % According to Section 4.2
    selected = A * S * D;
end

