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
imshow(frame);
[x,y]=ginput(2);
v1= [y(1),x(1)]; %%v1 and v2 are to be outputted in row,column format
v2=[y(2),x(2)];
centre = round((v2+v1)/2);
radii = round(abs(v2-v1)/2);
mF = markEllipse(frame, centre, radii);
imshow(mF); title('Tracking this region:'); pause(3.5);
close(fig)
end