function z = findPoints(image)

x = [];
y = [];

% change to a black and white image if necessary
if size(image, 3) > 1
    image = rgb2gray(image);
end

% go through every pixel
for i = 1 : size(image, 1)
    for j = 1 : size(image, 2)
        % if it's dark, save the location
        if (image(i, j) < 100)
            x(end + 1) = i;
            y(end + 1) = j;
        end

    end
end
% this is changing around x and y so it plots correctly
placeHolder = y;
y = -x;
x = placeHolder;
combined = [x;y];

% runs tsp on the matrix
matrix = tsp(combined);

% separates them
xNew = matrix(1, :);
yNew = matrix(2, :);

% creates a complex representation of the values
z = xNew + yNew * 1i;
z(end) = [];
end

