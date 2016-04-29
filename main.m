%% Main

global nBins whiteLevel lineThickness maxIters
nBins = int32(16); whiteLevel = 1; lineThickness = 2; maxIters = 20;

videoReader = vision.VideoFileReader('vid7.mp4');
videoWriter = vision.VideoFileWriter('out7.mp4', 'FrameRate', videoReader.info.VideoFrameRate, 'FileFormat', 'MPEG4');
curFrame = step(videoReader);
[centre, radii] = getObjectPosition(curFrame);
curFrameM = markEllipse(curFrame, centre, radii);
videoPlayer = vision.DeployableVideoPlayer('Size','Full-screen');
step(videoWriter, curFrameM);
step(videoPlayer, curFrameM);

curFrame_Q = getBinIndex(curFrame);
q_u = computeDistribution(curFrame_Q(...
    centre(1)-radii(1):centre(1)+radii(1),...
    centre(2)-radii(2):centre(2)+radii(2), :));

kValues=[]; bestCoeffs=[];
tic;
while ~isDone(videoReader)
    prevFrame_Q = curFrame_Q;
    curFrame = step(videoReader);
    curFrame_Q = getBinIndex(curFrame);
%     q_u = computeDistribution(prevFrame_Q(...
%         centre(1)-radii(1):centre(1)+radii(1),...
%         centre(2)-radii(2):centre(2)+radii(2), :));
    radiiRatios = [0.95,1,1.05];
    coeffs=zeros(numel(radiiRatios),1);
    positions = zeros(numel(radiiRatios),2);
    for ii = 1:numel(radiiRatios)
        positions(ii,:) = centre;
        tmpRadii = round(radiiRatios(ii)*radii);
        k=1;
        oldpos = [NaN, NaN];
        while(true)
%             display('Entered while loop');
            p_u = computeDistribution(curFrame_Q(...
                positions(ii,1)-tmpRadii(1):positions(ii,1)+tmpRadii(1),...
                positions(ii,2)-tmpRadii(2):positions(ii,2)+tmpRadii(2), :));
            coeffs(ii) = computeBhattacharyaCoefficient(q_u, p_u);
            pos = computeMeanShiftPosition(prevFrame_Q, q_u, curFrame_Q, p_u, positions(ii,:),radii, tmpRadii);
%             display('Computed position');
            if max(abs(pos - positions(ii,:))) < 0.5 || k > maxIters
                break;
            end
%             display('Updating, %f',sum((pos - positions(ii,:)).^2));
            oldpos = positions(ii,:);
            positions(ii,:) = round(pos);
            k=k+1;
        end
    end
    kValues = [kValues, k];
    [c,ind]=max(coeffs);
    bestCoeffs = [bestCoeffs, c];
    centre = positions(ind,:);
    radii = round(radiiRatios(ind) * radii);
    curFrameM = markEllipse(curFrame, centre, radii);
    step(videoWriter, curFrameM);
    step(videoPlayer, curFrameM);
end
toc;
release(videoWriter);
release(videoPlayer);
figure;
subplot(211); plot(kValues); title('k-Values');
subplot(212); plot(bestCoeffs); title('Best Bhattacharya Coefficients');