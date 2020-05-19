clear;

[data, k, samples, label] = prep_orl();

start = samples * (0:k-1) + 1;
S = data(start, :);
S = repmat(S, 1, 1, 30);

tic
[res, C] = kmeans(data, k, 'Distance', 'sqEuclidean', 'Replicates', 30, 'Maxiter', 30, 'start', S);
P = sum(res' == label) / (k * samples);
time = toc;
