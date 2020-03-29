#/bin/sh

# this script takes a screen capture of the currently active screen and saves it to ~/Pictures/SCREEN
# it gets the screen by a choice from the user

# get current time and date
YEAR=$(date +"%Y")
MONT=$(date +"%m")
DAY=$(date +"%d")
TIME=$(date +"%T")
# combine them how i want to
FILE="$YEAR-$MONT-$DAY~$TIME"

# read from menu
case "$1" in
	screen-1)
		scrot -a 1921,0,1920,1080 ~/Pictures/SCREEN/$FILE.png
		;;
	screen-2)
		scrot -a 0,0,1920,1080 ~/Pictures/SCREEN/$FILE.png
		;;
	rectangle)
		scrot -z -s -f ~/Pictures/RECTANGLE/$FILE.png
		;;
	all)
		scrot -z -m ~/Pictures/SCREEN/$FILE.png
		;;
	*)
		echo "Usage: $0 {active-window|screen-1|screen-2|rectangle|all}"
		exit 2
esac

exit 0
