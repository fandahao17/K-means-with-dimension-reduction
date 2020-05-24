function [] = plotData(data,label)
    figure;
    hold on;
    s = tsne(data, 'Perplexity', 50);
    l1 = find(label == 1);
    l2 = find(label == 2);
    l3 = find(label == 3);
    scatter(s(l1, 1), s(l1, 2), [], 'r');
    scatter(s(l2, 1), s(l2, 2), [], 'g');
    scatter(s(l3, 1), s(l3, 2), [], 'b');
end

