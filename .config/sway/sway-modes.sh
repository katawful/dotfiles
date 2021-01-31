#!/bin/sh

# This script controls our various modes only

## Bluetooth mode
# This gives us basic control over bluetooth devices
swaybluetooth()
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
swaycapture()
{

	# get current time and date
	YEAR=$(date +"%Y")
	MONT=$(date +"%m")
	DAY=$(date +"%d")
	TIME=$(date +"%T")
	# combine them how i want to
	FILE="$YEAR-$MONT-$DAY~$TIME"

	# read from sway mode menu
	case "$2" in
		active-window)
			activewingrim
			;;
		screen-1)
			grim -g "1921,0 1920x1080" ~/Pictures/SCREEN/"$FILE".png
			;;
		screen-2)
			grim -g "0,0 1920x1080" ~/Pictures/SCREEN/"$FILE".png
			;;
		rectangle)
			grim -g "$(slurp)" ~/Pictures/RECTANGLE/"$FILE".png
			;;
		all)
			grim ~/Pictures/SCREEN/"$FILE".png
			;;
		*)
			echo "Usage: $0 $1 {active-window|screen-1|screen-2|rectangle|all}"
			exit 2
	esac

	exit 0
}
# Capture the active window, passed off as function
activewingrim()
{
	# get window name
	NAME=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[], .floating_nodes[]) | select(.focused and .pid).name')
	# get window class from the active window name
	CLASS=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[], .floating_nodes[]) | select(.focused and .pid).app_id')
	# get current time and date
	YEAR=$(date +"%Y")
	MONT=$(date +"%m")
	DAY=$(date +"%d")
	TIME=$(date +"%T")
	# combine them how i want to
	FILE=$YEAR-$MONT-$DAY~$TIME

	# if the class doesn't exist just use the name instead
	if [ -z "$CLASS" ]; then
		if ls "/home/kat/Pictures/$NAME" ; then 
			cd "/home/kat/Pictures/$NAME"
			# scrot -u "$FILE".png
			grim -g "$(swaymsg -t get_tree | jq -r 'recurse(.nodes[], .floating_nodes[]) | select(.focused and .pid).rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$FILE".png
		else
			mkdir "/home/kat/Pictures/$NAME"
			cd "/home/kat/Pictures/$NAME"
			grim -g "$(swaymsg -t get_tree | jq -r 'recurse(.nodes[], .floating_nodes[]) | select(.focused and .pid).rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$FILE".png
		fi
	else
		if ls "/home/kat/Pictures/$CLASS" ; then 
			cd "/home/kat/Pictures/$CLASS"
			grim -g "$(swaymsg -t get_tree | jq -r 'recurse(.nodes[], .floating_nodes[]) | select(.focused and .pid).rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$FILE".png
		else
			mkdir "/home/kat/Pictures/$CLASS"
			cd "/home/kat/Pictures/$CLASS"
			grim -g "$(swaymsg -t get_tree | jq -r 'recurse(.nodes[], .floating_nodes[]) | select(.focused and .pid).rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$FILE".png
		fi
	fi

	cd $HOME
}

## sway Exit
# This lets us exit our i3 session in various ways
swayexit()
{
	case "$2" in
		logout)
			swaymsg exit
			;;
		suspend)
			systemctl suspend
			;;
		reboot)
			systemctl reboot
			;;
		shutdown)
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
	(--bluetooth) swaybluetooth "$@" ;;
	(--capture) swaycapture "$@" ;;
	(--exit) swayexit "$@" ;;
	(--active) activewinscrot "$@" ;;
esac
