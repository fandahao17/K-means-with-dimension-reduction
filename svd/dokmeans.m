clear;

k = 3; r = 10 * k;

[label, data, words] = prep();

bestp = 0;
bestf = 1;
ps = [];
for i= 1:100
    [features, selectedMatrix] = featureSelection(data, k, r);
    [res, C] = kmeans(selectedMatrix, k, 'Replicates', 10, 'Maxiter', 30);

    [P, F] = calc_result(data, res', label, k);
    if F < bestf
        bestp = P;
        bestf = F;
    end
    ps = [ps P];
end
bestp