function markedFrame = markEllipse(frame, centre, radii)

%%% Arguments: frame: a video frame
%%% tl, br: coordinates of top left and bottom right corner
%%%
%%% Output: markedFrame: frame with an ellipse

lTh = 3;        %line thickness

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r1 = radii(1); r2 = radii(2);
c1 = centre(1); c2 = centre(2);
rectWindow = frame(c1-r1:c1+r1, c2-r2:c2+r2, :);
selector = getEllipse(radii);
selector(lTh+1:end-lTh,lTh+1:end-lTh) = selector(lTh+1:end-lTh,lTh+1:end-lTh) & ~getEllipse(radii-lTh);
selector = repmat(selector,1,1,size(frame,3));  % if color image, we need a 3D selector 
markedWindow = rectWindow;
markedWindow(selector) = 255 - rectWindow(selector);
markedFrame = frame;
markedFrame(c1-r1:c1+r1, c2-r2:c2+r2, :) = markedWindow;
end