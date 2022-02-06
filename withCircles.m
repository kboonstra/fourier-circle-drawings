function withCircles(n, z)

% script to run everything

% finds the bounds so it looks nice (doesn't actually plot anything yet)
figure('visible','off');
plot(z);
scale = axis;

figure('visible','on');

% use other functions
z_hat = findConstants(z);

% runs our animation
animationWithCircles(z_hat, n, scale);