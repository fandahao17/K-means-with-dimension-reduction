clear;

k = 3; r = 10 * k;

[label, data, words] = prep();

[features, selectedMatrix] = featureSelection(data, k, r);
[res, C] = kmeans(selectedMatrix, k, 'Replicates', 30, 'Maxiter', 30);
res'
