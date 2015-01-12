function [ W ] = compute_weights( X, Y )

average = compute_mean_digits(X);

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

L = 21;
S = zeros(1000,L);
for i=1:1000,
    S(i,:) = [1 X(i,:)*average(1,:)' X(i,:)*average(2,:)' X(i,:)*average(3,:)' X(i,:)*average(4,:)' X(i,:)*average(5,:)' X(i,:)*average(6,:)' X(i,:)*average(7,:)' X(i,:)*average(8,:)' X(i,:)*average(9,:)' X(i,:)*average(10,:)' fill_count(X(i,:)) count_stripes(X(i,:),3,0) count_stripes(X(i,:),8,0) count_stripes(X(i,:),14,0) count_stripes(X(i,:),2,1) count_stripes(X(i,:),8,1) count_stripes(X(i,:),14,1) count_stripes(X(i,:),4,1) count_stripes(X(i,:),10,0) count_stripes(X(i,:),4,0)];
end

W = Y' * S * inv(S' * S + 5*eye(L));

%W * S(650,:)'

end