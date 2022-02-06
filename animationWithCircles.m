function animationWithCircles(z_hat, n, scale)

% sets correct scale and plots initial point and vector
axis(scale);
plotCirclesAndArrows(z_hat, n, 0);
hold on

lastSpot = [];

% finds the points to plot
for i = 0 : 0.0005 : 1
    [~, lastSpot(end + 1)] = arrows(z_hat, n, i);
end

% plots each vector and their associated point
for i = 1 : 2000
    hold on
    % vectors
    plotCirclesAndArrows(z_hat, n, i / 2000);
    plottedLastSpot = lastSpot(1:i);
    % last point
    plot(plottedLastSpot, '.', 'markerSize', 2, 'color', [0 0 0]);
    hold on
    axis(scale);
    
    % animates
    pause(0.0000000000000000001);
    
    % clears the previous set of vectors
    if i ~= 2000
        clf;
    end
    
end