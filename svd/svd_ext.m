clear;

% [label, data, words] = prep();

k = 40;
samples = 10;
load('~/Downloads/data.mat');
data = fea;
labels = zeros(1, subjects * samples);
for i = 1:subjects
        labels((i - 1) * samples + 1 : i * samples) = i;

[~, ~, V] = pca(data, k);

extm = data * V;

start = samples * (0:k-1) + 1;
S = extm(start, :);
S = repmat(S, 1, 1, 30);

[res, C] = kmeans(extm, k, 'Distance', 'sqEuclidean', 'Replicates', 30, 'Maxiter', 30, 'Start', S);

% [P, F] = calc_result(data, res', label, k);

P = sum(res' == label) / (k * samples);
