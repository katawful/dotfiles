#/bin/sh

# this script gets the active window and saves it to the folder with said name
# this uses wmctrl and/or xdotool to get the available windows
# for wmctrl, 'wmctrl -lx' lists the active windows
# columnn $3 is the class, starting from $5 is the window title name
# i am deleting the main columns first
# for xdotool i just need 'xdotool getwindowfocus getwindowname'

# get window name
NAME=$(xdotool getwindowfocus getwindowname)
# get current time and date
YEAR=$(date +"%Y")
MONT=$(date +"%m")
DAY=$(date +"%d")
TIME=$(date +"%T")
# combine them how i want to
FILE=$YEAR-$MONT-$DAY_$TIME

if ls "/home/kat/Pictures/$NAME" ; then 
	cd "/home/kat/Pictures/$NAME"
	scrot -u $FILE.png
else
	mkdir "/home/kat/Pictures/$NAME"
	cd "/home/kat/Pictures/$NAME"
	scrot -u $FILE.png
fi

cd $HOME
