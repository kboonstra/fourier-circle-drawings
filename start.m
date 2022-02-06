clc, clear, close all

% calls user interface
[vector, n, circles] = userInterface();
n = round(n / 2);
close all

% depending on if they want circles or not, calls the correct function
if circles == 1 
    withCircles(n, vector);
else
    noCircles(n, vector);
end