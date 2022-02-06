function circs = plotCirclesAndArrows(z_hat, n, t)

arrows = findVectors(z_hat, n, t)/length(z_hat); %divide by length(z_hat)
%because they sum over all the points instead of the average of all the 
%points; they don't sum over interval of [0,1] --> corrects for length of z
%and puts it in a timeframe of from t = 0 to t = 1

summedArrows = cumsum(arrows);

%ok tbh this circles thing is what I'm most unsure about... they don't
%always look the best and that's probably partly about aesthetic reasons
%(i.e. line width) but also I feel like the radii should generally make
%logical sense... that is, super large radius first and slowly
%decreasing... lmk what you think I tried a couple of indexes for the
%centers but this is the one that made most sense to me in a way

xCenters = [0, real(summedArrows)];
%take away the last one which has no needed radius
%would be 2n+1 but we add a zero at the beginning for origin
xCenters(2*n+2) = [];

yCenters = [0, imag(summedArrows)];
%take away the last one which has no needed radius
yCenters(2*n+2) = [];

%find centers for circle
centers = transpose([xCenters; yCenters]);

%abs of a complex number is radius
radii = abs(arrows);

plot(summedArrows,'-');
circs = viscircles(centers,radii,'LineWidth',1,'color','b');