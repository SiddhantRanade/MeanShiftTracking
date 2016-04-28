%% Main

global nBins whiteLevel lineThickness
nBins = int32(16); whiteLevel = 1; lineThickness = 3;

videoReader = vision.VideoFileReader('vid5.mp4');
videoWriter = vision.VideoFileWriter('out5.mp4', 'FrameRate', videoReader.info.VideoFrameRate, 'FileFormat', 'MPEG4');
curFrame = step(videoReader);
[centre, radii] = getObjectPosition(curFrame);
curFrameM = markEllipse(curFrame, centre, radii);
videoPlayer = vision.DeployableVideoPlayer('Size','Full-screen');
step(videoWriter, curFrameM);
step(videoPlayer, curFrameM);

q_u = computeDistribution(curFrame(...
        centre(1)-radii(1):centre(1)+radii(1),...
        centre(2)-radii(2):centre(2)+radii(2), :));

while ~isDone(videoReader)
    prevFrame = curFrame;
    curFrame = step(videoReader);
%     q_u = computeDistribution(prevFrame(...
%         centre(1)-radii(1):centre(1)+radii(1),...
%         centre(2)-radii(2):centre(2)+radii(2), :));
    radiiRatios = [0.95,1,1.05];
    coeffs=zeros(numel(radiiRatios),1);
    positions = zeros(numel(radiiRatios),2);
    for ii = 1:numel(radiiRatios)
        positions(ii,:) = centre;
        tmpRadii = round(radiiRatios(ii)*radii);
        k=1;
        while(true)
%             display('Entered while loop');
            p_u = computeDistribution(curFrame(...
                positions(ii,1)-tmpRadii(1):positions(ii,1)+tmpRadii(1),...
                positions(ii,2)-tmpRadii(2):positions(ii,2)+tmpRadii(2), :));
            coeffs(ii) = computeBhattacharyaCoefficient(q_u, p_u);
            pos = computeMeanShiftPosition(prevFrame, q_u, curFrame, p_u, positions(ii,:),radii, tmpRadii);
%             display('Computed position');
            if sum((pos - positions(ii,:)).^2) < 0.5
                break;
            end
%             display('Updating, %f',sum((pos - positions(ii,:)).^2));
            positions(ii,:) = round(pos);
            k=k+1;
        end
    end
    [~,ind]=max(coeffs);
    centre = positions(ind,:);
    radii = round(radiiRatios(ind) * radii);
    curFrameM = markEllipse(curFrame, centre, radii);
    step(videoWriter, curFrameM);
    step(videoPlayer, curFrameM);
end
release(videoWriter);
release(videoPlayer);