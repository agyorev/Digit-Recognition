clear all;

load mfeat-pix.txt -ascii;

all_samples = mfeat_pix(1:2000,:);

training = [];
test = [];

% separating the pictures/vectors for the different digits
for i=1:10, % 10 maps to 0
    from = (200 * mod(i, 10)) + 1;
    to = from + 99;
    training = [training; all_samples(from:to,:)];
    
    from = to + 1;
    to = from + 99;
    test = [test; all_samples(from:to,:)];
end

% the vectors for the wanted values
Y = zeros(1000,10); % a 1000 training examples, each with an id vector
for i=1:10,
    for j=1:100,
        % 1-100 -> 1
        % 101-200 -> 2
        % ...
        % 901-1000 -> 0/10
        Y((100 * (i-1)) + j, i) = 1;
    end
end

W = compute_weights(training, Y);

% evaluate the test data
X = test;
average = compute_mean_digits(X);
L = 21;
S = zeros(1000,L);
mis_count = zeros(1,10);
for i=1:1000,
    S(i,:) = [1 X(i,:)*average(1,:)' X(i,:)*average(2,:)' X(i,:)*average(3,:)' X(i,:)*average(4,:)' X(i,:)*average(5,:)' X(i,:)*average(6,:)' X(i,:)*average(7,:)' X(i,:)*average(8,:)' X(i,:)*average(9,:)' X(i,:)*average(10,:)' fill_count(X(i,:)) count_stripes(X(i,:),3,0) count_stripes(X(i,:),8,0) count_stripes(X(i,:),14,0) count_stripes(X(i,:),2,1) count_stripes(X(i,:),8,1) count_stripes(X(i,:),14,1) count_stripes(X(i,:),4,1) count_stripes(X(i,:),10,0) count_stripes(X(i,:),4,0)];
    [~,idx] = max(W * S(i,:)');
    wanted_idx = find(Y(i,:) == 1);
    if idx ~= wanted_idx,
        mis_count(wanted_idx) = mis_count(wanted_idx) + 1;
    end
end

mis_count
disp( [num2str(sum(mis_count) / 10), '% misclassification'] );