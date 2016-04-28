function distrib = computeDistribution(window)
%% Arguments : window: the rectangular patch that encloses the ellipse
%
% Outputs : distrib: the distribution

global nBins;

persistent normalizationConstants

sz = size(window);
h_r = (sz(1)-1)/2;
h_c = (sz(2)-1)/2;
[selector,rr,cc] = getEllipse([h_r,h_c]);       % rr,cc are measured from the centre of the window
n_h = sum(selector(:));
rr = rr/h_r; cc = cc/h_c;
vals = zeros(n_h, size(window,3));
for ll = 1:size(window,3)
    win = window(:,:,ll);
    vals(:,ll) =getBinIndex(win(selector));    % Maps [0,whiteLevel] to {1..16}
end
if(size(window,3) == 1)
    distrib = zeros(nBins,1);
elseif(size(window,3) == 3)
    distrib = zeros(nBins,nBins,nBins);
else
    error('window size in third dimension is invalid');
end
if(size(window,3) == 1)
    for ii = 1:n_h
        distrib(vals(ii)) = distrib(vals(ii)) + (1-rr(ii)^2-cc(ii)^2);
    end
else
    for ii = 1:n_h
        distrib(vals(ii,1), vals(ii,2), vals(ii,3)) = ...
            distrib(vals(ii,1), vals(ii,2), vals(ii,3)) + (1-rr(ii)^2-cc(ii)^2);
    end
end
try
    NC = normalizationConstants(h_r, h_c);
catch
    normalizationConstants(h_r,h_c) = sum(distrib(:));
    NC = normalizationConstants(h_r, h_c);
end
if NC == 0
    normalizationConstants(h_r,h_c) = sum(distrib(:));
    NC = normalizationConstants(h_r, h_c);
end
distrib = distrib/NC;
end