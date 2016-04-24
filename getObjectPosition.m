function [centre,radii]= getObjectPosition(frame)

%%% Arguments : x_pixels x y_pixels x 3  array for the image of the first
%%% frame
%%% Outputs :
%%% tl: Top left location of the window in pixel coordinates of the
%%% point marked in the image by the user.
%%% br : Bottom right location of the window in pixel coordinates of the
%%% point marked in the image by the user.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure;
imshow(frame, 'InitialMagnification', 200);
h=imellipse;
wait(h);
X=getPosition(h);
centre = round([X(2)+X(4)/2, X(1)+X(3)/2]); radii = round([X(4)/2, X(3)/2]);
delete(h);
close(fig)
end