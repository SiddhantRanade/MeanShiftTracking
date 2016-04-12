function [tl,br]= getObjectPosition(frame)

%%% Arguments : x_pixels x y_pixels x 3  array for the image of the first
%%% frame
%%% Outputs :
%%% tl: Top left location of the window in pixel coordinates of the
%%% point marked in the image by the user.
%%% br : Bottom right location of the window in pixel coordinates of the
%%% point marked in the image by the user.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure;
imshow(frame);
[x,y]=ginput(2);
tl= [y(1),x(1)]; %%tl and br are to be outputted in row,column format
br=[y(2),x(2)];
mF = markEllipse(frame, tl, br);
imshow(mF); title('Tracking this region:'); pause(3.5);
close(fig)
end