% timelapse.m
%
% Espen Storheim, tweaked by Mads Moldrheim.
%
% This script is designed to be used with a folder containing subfolders where the pictures are stored.
% It will iterate through the folders. This is designed for GoPro - the
% timelapse photos are stored in folders with up to 999 files.
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

function TimeLapseSubfolders(FolderAddress, ext, fr, ofname, step)

aname = [ofname '.mp4'];
vo = VideoWriter([ aname], 'MPEG-4');

% Framerate is the number of pictures per second.
vo.FrameRate = fr;

% Create the video.
open(vo);

% Get all the directories in the root folder:
dx = dir([FolderAddress ]);
% Loop through each folder and add the pictures to the video.
for i = 1:length(dx)
	isubfolname = [FolderAddress filesep dx(i).name filesep];
	dd = dir( [isubfolname '*.' ext] );
	for k = 1:step:length(dd)
		ifname=[isubfolname dd(k).name];
		[img, cmap]=imread( ifname);
		frame.cdata=img;
		frame.colormap=cmap;
		writeVideo(vo,frame);
    end
    % Printing to console how many folders have been completed of total
    formatSpec = "%.i of %.i folders";
    A = [i length(dx)];
    fprintf(compose(formatSpec,A))
end
fprintf('Task completed')
close(vo);
end
