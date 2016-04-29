function out = getBinIndex(in)
%% Arguments : window: the rectangular patch that encloses the ellipse
%
% Outputs : distrib: the distribution

global nBins whiteLevel
out = int8(ceil(in/whiteLevel*double(nBins)));
out(out == 0) = int8(1);
end