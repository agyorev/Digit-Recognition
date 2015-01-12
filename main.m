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
        % 901-1000 -> 0
        Y((100 * (i-1)) + j, i) = 1;
    end
end

average = compute_mean_digits(training);
% draw the 'perfect' digits
figure(1);
for j = 1:10,                                                            
    pic = average(j,:);                     
	picmatreverse = zeros(15,16);                                            
	% the filling of (:) is done columnwise!                                 
	picmatreverse(:)= - pic;                                                 
	picmat = zeros(15,16);                                                   
	for k = 1:15,
        picmat(:,k)=picmatreverse(:,16-k);
    end
	subplot(2,5, j );                                            
	pcolor(picmat');                                                         
	axis off;                                                                
	colormap(gray(10));                                                      
end

%c = find_best_tychonov ( training, average, Y );

% compute the optimal weights for the linear regression
W = compute_weights(training, average, Y, 1);
evaluate_model ( test, average, W, Y );
