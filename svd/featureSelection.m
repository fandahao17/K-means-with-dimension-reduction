function [features, selected] = featureSelection(A, k, r)
    [~, d] = size(A);
    % Compute the top-k right singular vectors of A
    [~, ~, V] = svd(A);
    Vk = V(:, 1:k);
    
    
    % Compute the normalized leverage scores
    p = vecnorm(Vk') .^ 2 / k;

    % r i.i.d sample
    features = sort(datasample(1:d, r, 'Replace', false, 'Weights', p));
    p(features)
    % Sampling matrix
%     S = zeros(d, r);
%     for i = 1 : r
%         S(features(i), i) = 1;
%     end
%     size(S);
    % Rescaling matrix
%     D = zeros(r, r);
%     for i = 1 : r
%         D(i, i) = 1 / sqrt(r * p(features(i)));
%     end

    % According to Section 4.2
%     selected = A * S * D;
    % [A(1, 1:100); selected(1, 1:100)]
    
    % Select
    selected = A(:, features);
    % Rescale
    selected = r ^ (-1/2) * selected .* (p(features) .^ (-1/2));
end

