% timelapse.m
%
% Espen Storheim, tweaked by Mads Moldrheim.
%
% This script is designed to be used with a single folder containing all
% the photos for the timelapse.
%
% Input:
% FolderAddress : Name of folder where the images/subfolders are located (must have a trailing / or \)
% ext : File extension of the images ('jpg', 'png', ...)
% fr : Framerate (number of images per second)
% ofname : Name of the video, without file extension.
% step : put 1 to include all photos, 2 to skip every other photo, 3 to
%       skip 2 photos at a time and so on. Use to speed up timelapse and make it
%       smaller in file size.
% 
%
% Usage:
% TimeLapse('C:\Bilder_Local\UAK2021\TimeLaps\Bridge\', 'jpg', 24, 'TimeLapse_IceBreaker', 1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function TimeLapse(FolderAddress, ext, fr, NewFileName, step)

aname = [NewFileName '.mp4'];
vo = VideoWriter([ aname], 'MPEG-4');

% Framerate is the number of pictures per second.
vo.FrameRate = fr;

% Create the video.
open(vo);

% Loop through each picture in the folder and add the pictures to the video.
dd = dir( [FolderAddress '*.' ext] );
for i = 1:step:length(dd)
	ifname=[FolderAddress dd(i).name];
	[img, cmap]=imread( ifname);
	frame.cdata=img;
	frame.colormap=cmap;
	writeVideo(vo,frame);
    % Printing progress to console for every 100 picture included in TL
    if mod(i-1,step*100)== 0
        formatSpec = "%.i of %.i";
        A = [i length(dd)];
        fprintf(compose(formatSpec,A))
    end
    end
fprintf('Task completed')
close(vo);
end


