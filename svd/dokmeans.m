clear;

k = 3; r = 10 * k;

[label, data, words] = prep();

bestp = 0;
ps = [];
for i= 1:50
    [features, selectedMatrix] = featureSelection(data, k, r);
    [res, C] = kmeans(selectedMatrix, k, 'Replicates', 10, 'Maxiter', 30);

    [P, F] = calc_result(data, res', label, k);
    if P > bestp
        bestp = P;
    end
    ps = [ps P];
end
bestp