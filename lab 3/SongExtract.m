function [output] = SongExtract(song,NumSec,fs)
SongLength = length(song);
GrabLength = NumSec*fs;
Mid = floor(SongLength/2);
    if SongLength <= GrabLength
        output = song;
    else
        output = song(Mid-GrabLength/2:Mid+GrabLength/2-1);
    end
end

