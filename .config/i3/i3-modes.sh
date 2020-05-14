#!/bin/sh

# This script controls our various modes only

## Bluetooth mode
# This gives us basic control over bluetooth devices
i3bluetooth ()
{
	case "$2" in
		disconnect)
			echo -e "disconnect\n" | bluetoothctl
			;;
		open-bluetoothctl)
			kitty bluetoothctl
			;;
		*)
			echo "Usage: $0 $1 {disconnect|open-bluetoothctl}"
			exit 2
	esac
}

## Capture monitor mode
# This lets us capture our screen in various ways
i3capture ()
{

	# get current time and date
	YEAR=$(date +"%Y")
	MONT=$(date +"%m")
	DAY=$(date +"%d")
	TIME=$(date +"%T")
	# combine them how i want to
	FILE="$YEAR-$MONT-$DAY~$TIME"

	# read from i3 mode menu
	case "$2" in
		active-window)
			activewinscrot
			;;
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
			echo "Usage: $0 $1 {active-window|screen-1|screen-2|rectangle|all}"
			exit 2
	esac

	exit 0
}
# Capture the active window, passed off as function
activewinscrot ()
{
	# get window name
	NAME=$(xdotool getwindowfocus getwindowname)
	# get current time and date
	YEAR=$(date +"%Y")
	MONT=$(date +"%m")
	DAY=$(date +"%d")
	TIME=$(date +"%T")
	# combine them how i want to
	FILE=$YEAR-$MONT-$DAY~$TIME

	if ls "/home/kat/Pictures/$NAME" ; then 
		cd "/home/kat/Pictures/$NAME"
		scrot -u $FILE.png
	else
		mkdir "/home/kat/Pictures/$NAME"
		cd "/home/kat/Pictures/$NAME"
		scrot -u $FILE.png
	fi

	cd $HOME
}

## i3 Exit
# This lets us exit our i3 session in various ways
i3exit ()
{
	case "$2" in
		logout)
			# NOTE these echoes are for my pywal theme switching
			echo "none" > "/home/kat/.cache/wal/stat"
			i3-msg exit
			;;
		suspend)
			echo "none" > "/home/kat/.cache/wal/stat"
			systemctl suspend
			;;
		reboot)
			echo "none" > "/home/kat/.cache/wal/stat"
			systemctl reboot
			;;
		shutdown)
			echo "none" > "/home/kat/.cache/wal/stat"
			systemctl poweroff
			;;
		*)
			echo "Usage: $0 $1 {logout|suspend|reboot|shutdown}"
			exit 2
	esac
	exit 0
}

# Run functions
case "$1" in
	(--bluetooth) i3bluetooth "$@" ;;
	(--capture) i3capture "$@" ;;
	(--exit) i3exit "$@" ;;
esac
