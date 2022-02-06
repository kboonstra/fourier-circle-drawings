% script for lab #9
mass = [0.15 0.17 0.2 0.22 0.25 0.27 0.3 0.32 0.35];
stretchesA = [0.6559 0.6941 0.7377 0.7675 0.8192 0.8497 0.8972 0.9334 0.9719];
stretchesB = [0.6559 0.6879 0.7349 0.7661 0.8145 0.8492 0.8905 0.9262 0.9760];
fg = [1.47 1.67 1.96 2.16 2.45 2.65 2.94 3.14 3.43];

coefficients = polyfit(stretchesB, fg, 1);
xFit = linspace(min(stretchesB), max(stretchesB), 1000);
yFit = polyval(coefficients , xFit);

p = plot(stretchesB, fg, 'b.','MarkerSize', 15);

hold on

plot(xFit, yFit, 'b-', 'LineWidth', 0.5);

xlabel('Stretch Length B (m)', 'Interpreter', 'latex')
ylabel('Force of Gravity (N)', 'Interpreter', 'latex')


grid on;