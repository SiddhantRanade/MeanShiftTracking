function shiftedPos = ...
    computeMeanShiftPosition( q_u, frame2_Q, p_u,y_current,h_next)
%% Arguments:
%
% 1)frame1: current frame (quantized)
% 2)frame2: next frame (quantized)
% 3) q_u   : Distribution of colours centered at the target in frame 1
% 4)p_u    :Distribution of chosen target candidate in the frame 2
% 5)y_current : Target location(center) in the current frame
% 6)h_current: Radii in the current frame
% 7)h_next : Radii in the next frame
%
% Outputs
% shiftedPos : Position of target candidate in the next frame

%BC_current = computeBhattacharyaCoefficient(p_u,q_u);
c1=y_current(1); %%Y coordinate of y_0(row number)
c2=y_current(2); %% X coordinate of y_0(column number)
%window = frame1(c1-r1:c1+r1, c2-r2 : c2+r2); %Rectangular window about current location 
[selector,r,c] = getEllipse(h_next); %Get the ellipse in the next window
roi_coords=[r + c1, c + c2];      %Region of interest: The points within the ellipse

n_h= size(roi_coords,1);  %The total number of pixels in the ellipse

%%Note that the function 'g' is a constant function. Dimensionality of the
%%vectors is 2 for which value of 'g' is 2/pi.
vals = zeros(n_h, size(frame2_Q,3));
for ll = 1:size(frame2_Q,3)
    win = frame2_Q(c1-h_next(1):c1+h_next(1),c2-h_next(2):c2+h_next(2),ll);
    vals(:,ll)=win(selector);    % Maps [0,whiteLevel] to {1..16}
end
addrs = sub2ind(size(q_u), vals(:,1), vals(:,2), vals(:,3));
wts = sqrt(q_u(addrs)./p_u(addrs));

normalisation_factor = sum(wts); %Normalisation factor given by eqn (26) denominator. Without the constant 2/pi

assert(normalisation_factor~=0, 'Normalisation factor is zero');

shiftedPos = (wts'*roi_coords(:,:))/normalisation_factor; %Mean shifted position

% C1=shiftedPos(1); C2=shiftedPos(2);
% R1=h_next(1);  %h_next is radius in the next window
% R2=h_next(2);  %(It is within 10% of h_current).
% Window=frame2(C1-R1:C1+R1,C2-R2:C2+R2,:); %Rectangular window in the next frame
% updated_p= computeDistribution(Window); 
% BC_next = computeBhattacharyaCoefficient(updated_p,q_u);

% while (BC_next < BC_current)
%     shiftedPos = 0.5*(shiftedPos + y_current); %Mean shift vector direction found. Probing for correct magnitude
%     C1= shiftedPos(1); C2= shiftedPos(2);
%     R1= h_next(1); R2=h_next(2);
%     Window=frame2(C1-R1:C1+R1,C2-R2:C2+R2,:);
%     updated_p= computeDistribution(Window);
%     BC_next = computeBhattacharyaCoefficient(updated_p,q_u);
% end
% The BC for the mean shifted position must be greater than the current
% position. Stop once that is achieved.
end
