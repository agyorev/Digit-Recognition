% a feature that counts the number of islands (connected parts,
% having grey value 0 ,disregard the ones that ar at the border
function [count] = fill_count(A)
dx = [ 0 -1  0 +1];
dy = [-1  0 +1  0];

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

% bfs
count = 0;
queue = [];
for i=1:16,
    for j=1:15,
        if img(i,j) == 0,
            key = 0;
            count = count + 1;
            queue = [i j];
            img(i,j) = 1;
            while isempty(queue) == 0,
                topx = queue(1,1);
                topy = queue(1,2);
                queue = queue(3:end);
                
                % we disregard the islands that start around the border
                if topx == 0 || topx == 16 || topy == 0 || topy == 15,
                    key = 1;
                end
                
                for k=1:4,
                    nx = topx + dx(k);
                    ny = topy + dy(k);
                    if 0 < nx && nx < 17 && 0 < ny && ny < 16,
                        if img(nx,ny) == 0,
                            img(nx,ny) = 1;
                            queue = [queue nx ny];
                        end
                    end
                end
            end
            count = count - key;
        end
    end
end

%figure(2)
%I = mat2gray(img, [0 6]);
%imshow(I)

end
