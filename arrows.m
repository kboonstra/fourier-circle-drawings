function [summedArrows, lastSpot] = arrows(z_hat, n, t)
%sorry, they're not really arrows—just lines; I think I would prefer lines
%tbh MATLAB is j annoying about changing function names

arrows = findVectors(z_hat, n, t)/length(z_hat); %divide by length(z_hat)
%because they sum over all the points instead of the average of all the 
%points; they don't sum over interval of [0,1] --> corrects for length of z
%and puts it in a timeframe of from t = 0 to t = 1

%no for loops wowwwww
summedArrows = cumsum(arrows);

lastSpot = summedArrows(end);