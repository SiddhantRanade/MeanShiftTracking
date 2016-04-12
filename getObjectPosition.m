function [tl,br]= getObjectPosition(frame1)

%%% Arguments : x_pixels x y_pixels x 3  array for the image of the first
%%% frame
%%% Outputs :
%%% tl: Top left location of the window in pixel coordinates of the
%%% point marked in the image by the user.
%%% br : Bottom right location of the window in pixel coordinates of the
%%% point marked in the image by the user.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
imshow(frame1);
[x,y]=ginput(2);
tl= [x(1,:),y(1,:)];
br=[x(2,:),y(2,:)];
end