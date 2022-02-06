function noCircles(n, z)

% finds the bounds so it looks nice (doesn't actually plot anything yet)
figure('visible','off');
plot(z);
scale = axis;

figure('visible','on');

% use other functions
z_hat = findConstants(z);

% runs our animation
animation(z_hat, n, scale);