% tests tsp with a monalisa image that only becomes clear when tsp is run
initial = load('mona-100k.txt')';

x = initial(1,:);
y = initial(2,:);

y = y * 1i;

z = x + y;

plot(z)
hold on
figure
matrix = tsp(initial);
x = matrix(1,:);
y = matrix(2,:);

y = y * 1i;

z1 = x + y;
plot(z1);
% 
% for i = 1 : 128 
%     plot(z(i))
%     pause(0.1)
% end