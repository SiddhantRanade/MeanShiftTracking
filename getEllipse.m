function [coords,R,C] = getEllipse(radii)
%% Arguments: radii: major and minor radii of ellips
%
% Output:
% coords: logical array of size 2*radius(1)+1 x 2*radius(2)+1 with points
% inside ellipse marked as 1, and those outside marked as 0.
% R, C: the r,c coordinates of the points inside the ellipse measured
% w.r.t the centre of the ellipse.

persistent coordsMem RMem CMem
r1 = radii(1); r2 = radii(2); compute = false;
try
    coords = coordsMem{r1, r2};
    R = RMem{r1, r2};
    C = CMem{r1, r2};
catch
    coordsMem{r1, r2}=[];
end
if isempty(coordsMem{r1,r2})
    compute = true;
end
if compute
    [R_0,C_0]=ndgrid(-r1:r1, -r2:r2);
    coords = (R_0/r1).^2 + (C_0/r2).^2 < 1;
    R = R_0(coords);
    C = C_0(coords);
    coordsMem{r1, r2} = coords;
    RMem{r1, r2} = R;
    CMem{r1, r2} = C;
end
end
