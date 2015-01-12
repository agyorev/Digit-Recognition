function [ S ] = compute_feature_vectors ( X, average )

L = 55; % # of features
[rows columns] = size(X);
S = zeros(rows,L);

for i=1:rows,
    bfs_feature = [fill_count(X(i,:))];

    cross_feature = [];
    for k=1:10,
        cross_feature = [cross_feature X(i,:)*average(k,:)'];
    end

    row_stripe_feature = [];
    for k=1:1:16,
        row_stripe_feature = [row_stripe_feature count_stripes(X(i,:),k,0)];
    end

    col_stripe_feature = [];
    for k=1:1:15,
        col_stripe_feature = [col_stripe_feature count_stripes(X(i,:),k,1)];
    end
    
    intensity_feature = [];
    for k=1:1:12,
        intensity_feature = [intensity_feature intensity_value(X(i,:),k)];
    end
    
    S(i,:) = [1 bfs_feature cross_feature row_stripe_feature col_stripe_feature intensity_feature];
end

end
