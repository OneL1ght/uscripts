#!/usr/bin/env fish

if not set -q argv[1]
	echo "pass the camera number!"
	exit 123
end
echo camera number: $argv[1]

unzip _video.zip

for f in $(fd ts .); ffmpeg -i $f -b:v 5000K -r 25 "$f.mp4"; end

vconcat 5

mkdir remove

fd camera -x mv {} remove/

mv result/001_005.mp4 camera2_full_130726.mp4

rm -r result/
