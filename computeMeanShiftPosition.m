function shiftedPos = ...
    computeMeanShiftPosition...
    (frame1, q_u, frame2, p_u,y_current,h_current,h_next)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Arguments:

%%% 1)frame1 :current frame
%%% 2)frame2 :next frame
%%% 3) q_u   : Distribution of colours centered at the target in frame 1
%%% 4)p_u    :Distribution of chosen target candidate in the frame 2
%%% 5)y_current : Target location(center) in the current frame
%%% 6)h_current: Radius in the current frame
%%% 7)h_next : Radius in the next frame
%%%
%%% Outputs
%%% shiftedPos : Position of target candidate in the next frame

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BC_current = computeBhattacharyaCoefficient(p_u,q_u);
c1=y_current(1); %%Y coordinate of y_0(row number)
c2=y_current(2); %% X coordinate of y_0(column number)
r1=h_current(1);
r2=h_current(2);
%coords = getEllipse(h_current);
%window = frame1(c1-r1:c1+r1, c2-r2 : c2+r2); %Rectangular window about current location 
[selector,r,c] = getEllipse(h_current); %Get the ellipse about the current window
%[r,c]=find(selector);  %Obtain indices of entries in the ellipse in [row,column] form
roi_coords=[r,c];      %Region of interest: The points within the ellipse
roi_coords(:,1)=roi_coords(:,1) + c1; %Translate by y_0 to 
roi_coords(:,2)=roi_coords(:,2)+c2;   %obtain x_i's in eqn 26 in paper

n_h= size(roi_coords,1);  %The total number of pixels in the ellipse

wts=zeros(n_h,1); 

normalisation_factor = 2*sum(wts)/pi; %Normalisation factor given by eqn (26) denominator.
%%Note that the function 'g' is a constant function. Dimensionality of the
%%vectors is 2 for which value of 'g' is 2/pi.

for i=1:n_h
    colour = frame1(roi_coords(i,1),roi_coords(i,2),:); %Get the colour of the pixel
    index=ceil(((colour+1)/256)*16); %Find the index of the bin(in the histogram) to which the colour belongs
    wts(i)=sqrt(q_u(index)/p_u(index));  %Formula for weights: eqn(25) in the paper
    shiftedPos=shiftedPos + ...
        (roi_coords(i,:)*wts(i)*2/pi)/normalisation_factor; %Mean shifted position
end
C1=shiftedPos(1); C2=shiftedPos(2);
R1=h_next(1);  %h_next is radius in the next window
R2=h_next(2);  %(It is within 10% of h_current).
Window=frame2(C1-R1:C1+R1,C2-R2:C2+R2); %Rectangular window in the next frame
updated_p= computeDistribution(Window); 
BC_next = computeBhattacharyaCoefficient(updated_p,q_u);

while (BC_next < BC_current)
    shiftedPos = 0.5*(shiftedPos + y_current); %Mean shift vector direction found. Probing for correct magnitude
    C1= shiftedPos(1); C2= shiftedPos(2);
    R1= h_next(1); R2=h_next(2);
    Window=frame2(C1-R1:C1+R1,C2-R2:C2+R2);
    updated_p= computeDistribution(Window);
    BC_next = computeBhattacharyaCoefficient(updated_p,q_u);
end
% The BC for the mean shifted position must be greater than the current
% position . Stop once that is achieved.
end
