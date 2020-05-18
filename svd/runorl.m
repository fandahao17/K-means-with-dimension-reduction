clear;

[data, k, samples, label] = prep_orl();

r = 50;

start = samples * (0:k-1) + 1;
% bestp = 0;
% bestf = 1;
ps = [];
ts = [];
for r= 5:5:300
    tic
    [features, selectedMatrix] = featureSelection(data, k, r);
    S = selectedMatrix(start, :);
    S = repmat(S, 1, 1, 30);

    [res, C] = kmeans(selectedMatrix, k, 'Distance', 'sqEuclidean', 'Replicates', 30, 'Maxiter', 30, 'start', S);
    ts = [ts toc];
    P = sum(res' == label) / (k * samples);
    ps = [ps P];
    r
end

%     [P, F] = calc_result(data, res', label, k);
%     if F < bestf
%         bestp = P;
%         bestf = F;
%     end
%     ps = [ps P];
% end
% bestp