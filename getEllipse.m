function coords = getEllipse(radii)

%%% Arguments: radii: major and minor radii of ellips
%%%
%%% Output: coords: logical array of size 2*radius(1)+1 x 2*radius(2)+1 with points
%%% inside ellipse marked as 1, and those outside marked as 0.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r1 = radii(1); r2 = radii(2);
[R_0,C_0]=ndgrid(-r1:r1, -r2:r2);
coords = (R_0/r1).^2 + (C_0/r2).^2 <= 1;