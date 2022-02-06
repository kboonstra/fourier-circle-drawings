function [vector, n, boolean] = userInterface()

boolean = false;

clc, close all
% Initialize the board with all indices dead.
n_rows = 200; % starting number of rows
n_cols = 200; % starting number of columns
board = zeros(n_rows,n_cols);
n_vectors = 0;
x = [];
y = [];
vector = [];

% The following lines are used to create elements of the GUI which the user
% can control to change factors of the output image

% Create figure window and mouse callbacks. Fill screen (almost)
% with figure window in the center of the screen.
figure('WindowButtonDownFcn',@click,...
    'WindowButtonUpFcn',@release,...
    'WindowButtonMotionFcn',@move,...
    'Units','normalized','position',[.05 .1 .9 .8]);

% Plot the inital board and grid on a new pair of axes.
[im,a] = regeneratePlot(board,n_rows,n_cols,NaN);

% Static text above the matrix plot.
tString = {'Right click and drag to add live cells.', ...
        'Do this in one motion (do not go back to fill in points).',...
        'Do not worry if the line is not completely connected.'...
        'For best results your drawing should be a closed loop.'};

uicontrol('Style','text','Units','normalized',...
    'Position',[.1 .82, .5, .1],'String',tString,'FontSize',12)

% Edit text box to change the number of rows.
ui_row = uicontrol('Style','edit','Units','normalized',...
    'Position',[.72 .67, .1, .1],'FontSize',16,...
    'Callback',@numberVectors);

ui_row.String = num2str(n_vectors);

% Static text above the number of vectors text box.
tString2 = {'Number of vectors.'...
    'Drawing: 10-50 vectors.'...
    'Parametric: 10-50 vectors.'...
    'Image: 100-200 vectors.'};
    
uicontrol('Style','text','Units','normalized',...
    'Position',[.67, .78, .2, .15],'String', tString2, 'FontSize',16);


tString2 = {'Pick one of the three: parametric equation, drawing, or uploading an image'};
    
uicontrol('Style','text','Units','normalized',...
    'Position',[.2, .93, .6, .06],'String', tString2, 'FontSize',20);


% Pushbutton to open an existing file.
uicontrol('Style','Pushbutton','Units','normalized',...
    'Position',[.63, .47, .28, .1],'FontSize',16,...
    'String','Open existing file','Callback',@openFile);

tString = {'Input a parametric equation with the style:'...
    'x = 2*cos([0:0.01:2*pi]); y = 2*sin([0:0.01:2*pi])'};

uicontrol('Style','text','Units','normalized',...
    'Position',[.63 .35, .28, .1],'String',tString,'FontSize',16)

uicontrol('Style','edit','Units','normalized',...
    'Position',[.63, .27, .28, .1],'FontSize',16,...
    'String','','Callback',@parametricPlot);

uicontrol('Style','pushbutton','Units','normalized',...
    'Position',[.63, .1, .28, .1],'FontSize',16,...
    'String','Click when done.','Callback',@done);

uicontrol('style','checkbox','Units','normalized',...
    'position',[.63, .57, .35, .1],'FontSize',16,'string',...
    'Plot with circles (not recommended for images)','Callback',@circleOrVector);

% Variable used to track if a mouse button was pressed. Takes on
% the value of 1 if the left mouse button was pressed, 0 if the
% right mouse button was pressed, and NaN otherwise. When val=NaN
% it blocks the mouse button motion function.
val = NaN;


    function click(h,~)
        % CLICK. Executes when a mouse button is pressed.
        % Determines the button that was pressed and updates
        % control variable val accordingly.
        
        % Determine which mouse button was pressed.
        switch h.SelectionType
            case 'normal' % left click
                val = 1;
                
            case 'alt' % right click
                val = 0;
        end
        
        % Call the move function, which will get the position of
        % the mouse and update the GOL plot.
        move
    end



    function release(varargin)
        % RELEASE. Resets val to NaN (its mouse motion blocking
        % state) upon release of a mouse button.
        
        val = NaN;
    end

    function done(~, ~)
        % RELEASE. Resets val to NaN (its mouse motion blocking
        % state) upon release of a mouse button.
        
        close all;
    end



    function move(varargin)
        % MOVE. Executes when mouse button motion is detected.
        % Adds or deletes alive cells from the game of life board
        % depending on the value of val, which is inherited from
        % the mouse button down callback.
        
        % Get the cursor position. Round to nearest integer so
        % the position can be used to address the indices of
        % board.
        pos = get (gca, 'CurrentPoint');
        col = round(pos(1,1)); row = round(pos(1,2));
        
        % Update the GOL board if the pointer is within the axes
        % bounds and a mouse button has been pressed but not yet
        % released.
        if row >= 1 && row <= n_rows && col >= 1 && ...
                col <= n_cols && ~isnan(val)
            board(row,col) = val;
            updatePlot
            x(end + 1) = col;
            y(end + 1) = row;
            vector(end + 1) = x(end) + 1i * y(end);
        end
    end

    function numberVectors(h,~)
        % ADJUSTROW. Update the number of rows on the board if
        % the user changes the number of rows in the number of
        % rows edit text box.
        
        % Get number of rows from edit text box. Round in case
        % the user enter a non-integer.
        n = round(str2double(h.String));
    end

    function parametricPlot(h,~)
        eval(h.String);
        vector = x+1i*y;
        plot(vector)
    end

    function circleOrVector(h,~)
        vals = get(h,'Value');
        boolean = max(vals);
    end

    function openFile(varargin)
        % OPENFILE. Executes when the open file pushbotton is
        % pressed.
        
        % Open a file opener dialogue.
        [filename, path] = uigetfile('*.jpg');
        
        % Load the file and update the number of rows, columns,
        % and the filename. Utilizes try/catch in case the user
        % x's out of the dialogue, fails to select a file, or
        % selects the wrong type of file.
        try
            m = imread(strcat(path, filename));
            imshow(m);

        catch
            disp('Something went wrong during the load!')
        end
        vector = findPoints(m);
    end



    function updatePlot
        % UPDATEPLOT. Updates the color data of the Game of Life
        % board being designed.
        
        im.CData = board;
    end
uiwait
end



function [im,a] = regeneratePlot(board,n_rows,n_cols,a)
% REGENERATEPLOT. Recreates a visual representation of the GOL
% board and adds a grid. Grid addition required a bit of
% hackiness due to the limitations of imagesc().

% Outputs the handle to the plot as im and the handle to the axes
% as a. Input board is the GOL matrix. Inputs n_rows and n_cols
% represent the number of rows and columns of the board. a is the
% handle to the axes.

% Delete the old axes. Otherwise, a ghost of the old axes will be
% left behind if the axes change shape due to a row or column
% size change.
if ishandle(a)
    delete(a)
end

% Plot the inital board on a new pair of axes.
a = axes('Position',[.1 .1 .5 .7]);
im = imagesc(board);
colormap(flipud(gray))
caxis([0 1])

% Create a grid, color gray. Offset gridlines by .5; required as
% plotting was achieved with imagesc, which visually shifts the
% index centers by .5.
hold on
for jj = 1:n_rows
    line([1-.5, n_cols+.5], [jj-.5, jj-.5], 'Color', [.5 .5 .5])
end

for jj = 1:n_cols
    line([jj-.5, jj-.5], [1-.5, n_rows+.5], 'Color', [.5 .5 .5])
end
hold off

% Change from a flipped y origin (a result of imagesc, places y
% origin at top of plot) to standard orientation (y origin at
% bottom), scale the x and y axes equivalently so that cells have
% a square appearance no matter the number of rows and columns,
% and squeeze the axes bounds to the extents of the data.
axis xy equal tight
end