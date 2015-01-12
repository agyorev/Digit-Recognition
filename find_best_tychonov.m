% using 10-fold x-validation
function [tcoef] = find_best_tychonov ( X, average, Y )

[rows columns] = size(X);

coef = [];
errs = [];

for c=1:1:10,

    acc_error = 0;
    for i=1:10,
        disp ( ['running x-vaildation for c=', num2str(c), ' mc=', num2str(i)] );
        train_set = [];
        train_set_exp = [];
        test_set = [];
        test_set_exp = [];

        for j=1:rows,
            if mod(j,10) == mod(i,10),
                test_set = [test_set; X(j,:)];
                test_set_exp = [test_set_exp; Y(j,:)];
            else
                train_set = [train_set; X(j,:)];
                train_set_exp = [train_set_exp; Y(j,:)];
            end
        end

        W = compute_weights(train_set, average, train_set_exp, c);
        acc_error = acc_error + evaluate_model(test_set, average, W, test_set_exp);
    end

    coef = [coef c];
    errs = [errs acc_error/10];

end

figure(2);
coef
errs
plot ( coef, errs );
title ( 'Cross-validation test error' );
xlabel ( 'Coeficiant value' );
ylabel ( 'Misclassification %' );

[merr, idx] = min(errs);
tcoef = coef(idx);

end
