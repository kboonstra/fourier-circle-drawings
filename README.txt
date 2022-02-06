/********************************************************
* README.txt
* ENGR105 - Fourier Transformation Circle Drawings - 2021
********************************************************/

Authors: Kepler Boonstra & Nathan Sobotka

Instructions:
1. Use start.m to begin running.
2. Follow GUI instructions.  If you'd like to upload an image, we have provided a few in the folder.  Here is an example (parametric) equation to use:

x = 16*sin([0:0.01:2*pi]).^3; y = 13*cos([0:0.01:2*pi]) - 5*cos(2*[0:0.01:2*pi]) - 2*cos(3*[0:0.01:2*pi]) - cos(4*[0:0.01:2*pi]);

In this project, we use Fourier transformation algorithms to find complex coordinates of a line drawing, and then approximate them using vectors.

We began with parametric equations and applying our functions to them.  Now, inputted correctly, they should always work as expected.  In fact, any set of x-y (where y is in the imaginary plane) points will work—so any inputted data is able to be plotted.  Although the original intention was for the input-equation box in the GUI to be for parametric only, this means it can actually approximate a lot more.

We then began to experiment with having the user draw an image and also uploading one.  We were mostly successful in approximating drawings created by the user and approximating uploaded JPEG images.  The fast Fourier transformation function runs on points, not equations, so we were able to have the user draw a number of points and simply record them in order.

Uploading images was far more complex.  Originally, we intended to be able to perfectly approximate an image by uploading an .svg file (which would contain data about when and how the line plot would move).  MATLAB, however, does not currently have support for .svg files.  To work around this, we decided to use JPEGs and find the pixel location of every point on the line, and then put them in order using a Traveling Salesperson function.  The function, although it does exactly what it is supposed to, is not perfect—as can be seen when plotted.  It does not always follow the path a human could see.  This means that more complicated drawings don't replicate extraordinarily well.  However, this method of Fourier circle drawings is unique to us—most online only work with svgs and drawings.  Working with JPEGs allows the user to have many more drawings that can be put in and it is far less limiting than only allowing svg images.

Axes of the plot were set using data from the original image, but also sometimes become slightly distorted.  To bypass this, once the drawing is complete, one may simply change the size of the window.

The speed itself for the vector drawings is unable to be edited as the algorithm for point approximation must be made at each time-step.  This means—sometimes, with many points—it moves quite slowly.

Skills demonstrated include:
1. Algorithm development - This project is highly mathematical and required newly found understanding of more complex (pun intended) concepts.  We also included a sort of project in a project with the tsp.m function.
2. Animation
3. Logical indexing
4. GUI - Although the part for drawing an image was adapted from the Game of Life Board code, we spent a lot of time working on other elements and adapting it for our project.

Toolboxes Used: Image Processing Toolbox
