function coeff = computeBhattacharyaCoefficient(window1, window2)

%%% Arguments : two windows window1 and window2
%%% Outputs :
%%% coeff: the Bhattacharya coefficient
%%% Uses the computeDistribution function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = computeDistribution(window1);
q = computeDistribution(window2);
dp = sqrt(p) .* sqrt(q);
coeff = sum(dp(:));
end