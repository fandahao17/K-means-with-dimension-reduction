function [labels, data, word] = prep()
    load('./nips_1-17.mat');
    cn = find(contains(docs_names, 'CN'));
    lt = find(contains(docs_names, 'LT'));
    ns = find(contains(docs_names, 'NS'));
    rows = sort([cn lt ns]);
    mycounts = counts(:, rows)';
    labels = ones(1, length(rows));
    names = docs_names(rows);
    labels = labels + contains(names, 'LT');
    labels = labels + 2 * contains(names, 'NS');
    
    A = find(sum(mycounts));
    data = full(mycounts(:, A));
    word = words(A);
end

