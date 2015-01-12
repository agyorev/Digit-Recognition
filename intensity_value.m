% with this feature value we split the image on quadrants (4 by 3)
% and return the average grayscale value
function [mean] = intensity_value(A,idx)
G = zeros(15,16);
pic = A(1,:);
picm = zeros(15,16);
picm(:) = - pic;                                                  
for k = 1:15,
	G(:,k)=picm(:,16-k);
end

G = -G;
img = flipud(G');

start_row = fix(idx/3) + 1;
if mod(idx,3) == 0,
    start_row = start_row - 1;
end

start_col = mod(idx,3);
if start_col == 0,
    start_col = 3;
end

% computing the final values of the starting cell of the 4x5 quadrant block
start_row = ((start_row - 1) * 4) + 1;
start_col = ((start_col - 1) * 5) + 1;

submatrix = img(start_row:(start_row+3), start_col:(start_col+4));
mean = sum(submatrix(:)) / 20;

end