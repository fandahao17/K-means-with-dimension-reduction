function [P,F] = calc_result(A, clusters, label, num_clusters)
    % Calculate F
    num = [sum(clusters == 1) sum(clusters == 2) sum(clusters == 3)];
    
    [rows, ~] = size(A);
    X = zeros(rows, num_clusters);
    
    for i=1 : rows
        X(i, clusters(i)) = 1 / sqrt(num(clusters(i)));
    end
    
    F = (norm(A - X * X' * A, 'fro') / norm(A, 'fro')) ^ 2;
    
    % Calculate P
    orders = [1 2 3; 1 3 2; 2 1 3; 2 3 1; 3 1 2; 3 2 1];
    p1 = label == 1;
    p2 = label == 2;
    p3 = label == 3;
    P = 0;
    for i= 1:length(orders)
        order = orders(i, :);
        curp = sum(clusters(p1) == order(1)) + sum(clusters(p2) == order(2)) + sum(clusters(p3) == order(3));
        curp = curp / 184;
        if curp > P
            P = curp;
        end
    end       
end

