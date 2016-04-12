function markedFrame = markEllipse(frame, tl, br)

%%% Arguments: frame: a video frame
%%% tl, br: coordinates of top left and bottom right corner
%%%
%%% Output: markedFrame: frame with an ellipse

lTh = 3;        %line thickness

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
radii = (br-tl)/2; r1 = radii(1); r2 = radii(2);
centre = (br+tl)/2; c1 = centre(1); c2 = centre(2);
[R,C,~] = ndgrid(1:size(frame, 1), 1:size(frame,2), 1:size(frame,3));
selector1 = (R-c1).^2/r1^2 + (C-c2).^2/r2^2 >= 1;
selector2 = (R-c1).^2/(r1+lTh)^2 + (C-c2).^2/(r2+lTh)^2 <= 1;
markedFrame = frame;
markedFrame(selector1 & selector2) = 255 - markedFrame(selector1 & selector2);
end