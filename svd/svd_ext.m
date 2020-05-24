clear;

% [label, data, words] = prep();

[data, k, samples, label] = prep_orl();

[~, ~, V] = fastsvd(data, k);

extm = data * V;

start = samples * (0:k-1) + 1;
S = extm(start, :);
S = repmat(S, 1, 1, 30);

[res, C] = kmeans(extm, k, 'Distance', 'sqEuclidean', 'Replicates', 30, 'Maxiter', 30, 'Start', S);

% [P, F] = calc_result(data, res', label, k);

P = sum(res' == label) / (k * samples);
