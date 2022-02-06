function plotArrows(z_hat, n, t)

arrows = findVectors(z_hat, n, t)/length(z_hat); %divide by length(z_hat)
%because they sum over all the points instead of the average of all the 
%points; they don't sum over interval of [0,1] --> corrects for length of z
%and puts it in a timeframe of from t = 0 to t = 1

%no for loops wowwwww
summedArrows = cumsum(arrows);

arrows = plot(summedArrows,'-');
