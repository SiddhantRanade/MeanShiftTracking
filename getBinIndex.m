function out = getBinIndex(in)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Arguments : window: the rectangular patch that encloses the ellipse
%%%
%%% Outputs : distrib: the distribution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global nBins whiteLevel;
out = ceil(in/whiteLevel*nBins);
out(out == 0) = 1;
end