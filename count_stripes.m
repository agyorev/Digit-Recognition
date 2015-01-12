% count the number of stripes that have value > 2
% type = 0 - row wise
% type = 1 - col wise
function [count] = count_stripes(A,idx,type)
% some preprocessing of the image to make it easier to
% compute the feature from
G = zeros(15,16);
pic = A(1,:);
picm = zeros(15,16);
picm(:) = - pic;                                                  
for k = 1:15,
	G(:,k)=picm(:,16-k);
end

G = -G;
img = flipud(G');

%figure(2)
%I = mat2gray(img, [0 6]);
%imshow(I)

prev = 0;
count = 0;
if type == 0,
    for i=1:15,
        if prev < 3 && img(idx,i) > 2,
            count = count + 1;
        end
        prev = img(idx,i);
    end
else
    for i=1:16,
        if prev < 3 && img(i,idx) > 2,
            count = count + 1;
        end
        prev = img(i,idx);
    end
end

end