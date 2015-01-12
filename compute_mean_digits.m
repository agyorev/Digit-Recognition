function [ A ] = compute_mean_digits ( X )

% get the average/perfect digit representation
A = zeros(10,240);
for i=1:10,
    from = ((i-1) * 100) + 1;
    to = from + 99;
    A(i,:) = round(sum(X(from:to,:)) / 100);
end

end