% to evaluate the resulsts we need:
% out test data X
% the average of the digits
% the weights W
% the wanted results Y, corresponding to each row if X
function [cerror] = evaluate_model ( X, average, W, Y )

mis_count = zeros(1,10);
S = compute_feature_vectors(X, average);
[rows columns] = size(X);

for i=1:rows,
    [~,idx] = max(W * S(i,:)');
    wanted_idx = find(Y(i,:) == 1);
    if idx ~= wanted_idx,
        mis_count(wanted_idx) = mis_count(wanted_idx) + 1;
    end
end

mis_count

cerror = 100 * sum(mis_count) / rows;
disp( [num2str(cerror), '% misclassification'] );

end
