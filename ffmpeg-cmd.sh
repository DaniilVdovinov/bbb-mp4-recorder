#!usr/bin/sh
DURATION=$1
EXPORT_NAME=$2
DISPLAY_NUMBER=$3
DISPLAY_SIZE=$4
Y_OFFSET=$5
X_OFFSET=$6

#Record the BBB playback, playing in Google browser in xvfb virtual screen, as MP4 video
ffmpeg -y -nostats -draw_mouse 0 -s $DISPLAY_SIZE \
	-framerate 30 \
	-f x11grab -thread_queue_size 1024 \
	-grab_y $Y_OFFSET \
	-grab_x $X_OFFSET \
	-i :$DISPLAY_NUMBER \
	-f alsa -thread_queue_size 1024 \
	-i pulse -ac 2 \
	-c:v libx264 -c:a aac  \
	-crf 22  \
	-pix_fmt yuv420p \
	-preset fast \
	-movflags faststart \
	-t $DURATION \
	/usr/src/app/processing/$EXPORT_NAME.mp4

# move the video to the processed folder
echo "Moving video to processed folder"
mv /usr/src/app/processing/$EXPORT_NAME.mp4 /usr/src/app/processed/$EXPORT_NAME.mp4