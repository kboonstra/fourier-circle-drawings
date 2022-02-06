function matrix = tsp(m) 

% create two vectors and initialize two empty ones
x = m(1,:);
y = m(2,:);

xNew = [];
yNew = [];

% fill the initial two spots in the empty vector
xNew(1) = x(1);
yNew(1) = y(1);

xNew(2) = x(2);
yNew(2) = y(2);

% make the final spot the starting spot
xNew(3) = x(1);
yNew(3) = y(1);


% go through every remaining point
for i = 3 : length(m)
    % make an absurdly large minDistance
    minDistance = 1000000;
    % minlocation is the last possible location to insert the new point
    minLocation = length(xNew) - 1;
    for j = 1 : length(xNew) - 1
        % this calculates the added distance of a new point at each spot
        dist13 = ((xNew(j) - xNew(j + 1)) ^ 2 + (yNew(j) - yNew(j + 1))...
           ^ 2) ^ 0.5;
        dist12 = ((xNew(j) - x(i)) ^ 2 + (yNew(j) - y(i))^2) ^ 0.5;
        dist23 = ((xNew(j + 1) - x(i))^2 + (yNew(j + 1) - y(i)) ^ ...
            2) ^ 0.5;
        distChange = dist12 + dist23 - dist13;
        % if that new added distance is less than a previous smallest, we
        % want to insert the point at that smallest distance location
        if (distChange < minDistance)
            minDistance = distChange;
            minLocation = j;
        end
    end

    % create new output vectors. Unsure on why it required this method, but
    % it was throwing errors when it wasn't broken down into tiny steps. 
    out = [xNew(1:minLocation)];
    out1 = [xNew(minLocation + 1: end)];
    out = [out, x(i), out1];
    xNew = out;
    out = [yNew(1:minLocation)];
    out1 = [yNew(minLocation + 1: end)];
    out = [out, y(i), out1];
    yNew = out;
end

% combine the output into one
matrix = [xNew;yNew];

end