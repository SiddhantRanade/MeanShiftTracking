%% Main

global nBins whiteLevel;
nBins = 16;
whiteLevel = 1;

videoReader = vision.VideoFileReader('video.mp4');
videoWriter = vision.VideoFileWriter('output.mp4', 'FrameRate', videoReader.info.VideoFrameRate, 'FileFormat', 'MPEG4');
videoPlayer = vision.VideoPlayer;
frame = step(videoReader);
[centre, radii] = getObjectPosition(frame);

while ~isDone(videoReader)
    frame = step(videoReader);
    step(videoWriter, frame);
    step(videoPlayer, frame);
end
release(videoWriter);
release(videoPlayer);