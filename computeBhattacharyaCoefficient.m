function coeff = computeBhattacharyaCoefficient(d1, d2)

%%% Arguments : two distributions d1 and d2 -- arrays of size 16 x 16 x 16,
%%% the 16 is not fixed yet, it's a tunable parameter inside the
%%% computeDistribution function
%%%
%%% Outputs : coeff: the Bhattacharya coefficient


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
coeff = sum(sqrt(d1(:)).*sqrt(d2(:)));
end