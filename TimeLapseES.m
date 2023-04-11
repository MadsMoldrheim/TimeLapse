% timelapse.m
%
% Espen Storheim.
% 
% Creates a timelapse video of a set of images.
%
% This script is designed to be used with a GoPro camera, where 999 images are stored in each subfolder.
%
% Input:
% ifolname : Name of folder where the images are located (must have a trailing / or \)
% ext : File extension of the images ('jpg', 'png', ...)
% fr : Framerate (number of images per second)
% ofname : Name of the video, without file extension.
%
% 
%
% Usage:
% timelapse('/Volumes/NO NAME/DCIM/', 'jpg', 24, 'test')
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function TimeLapseES(ifolname, ext, fr, ofname)

aname = [ofname '.mp4'];
vo = VideoWriter([ aname], 'MPEG-4');

% Framerate is the number of pictures per second.
vo.FrameRate = fr;

% Create the video.
open(vo);

% Get all the directories in the root folder:
dx = dir([ifolname ]);
% Loop through each folder and add the pictures to the video.
for ii = 3:length(dx)
	isubfolname = [ifolname filesep dx(ii).name filesep];
	dd = dir( [isubfolname '*.' ext] );
	for ik = 1:length(dd)
		ifname=[isubfolname dd(ik).name];
		[img, cmap]=imread( ifname);
		frame.cdata=img;
		frame.colormap=cmap;
		writeVideo(vo,frame);
    end
end

close(vo);
end
