#!/bin/sh

# This script launchs various apps that need to be in scripts

## Launch htop
# I use this floating with i3 to give me a quick look at usage
htop ()
{
	#set window title
	echo -ne "\033]0;"htop"\007"

	# run htop
	kitty "htop"
}

## Launch conky
# I use conky to show my system info at a glance
conky ()
{
	#set window title
	#echo -ne "\033]0;"conky"\007"

	#runs conky with my custom menu in terminal
	conky -c "/home/kat/.config/conky/conky.conf"
}

## Launch games with Dolphin
# I use this to launch games with Dolphin bare
# The default GUI command options suck
dolphin ()
{
	FILE=$3 # filename
	SYS=$2 # system

	# run dolphin in background
	dolphin-emu-nogui -e "/run/media/HDD/ROMs/$SYS/$FILE" &
	# wait two seconds
	sleep 2s
	# set the window class to "dolphin-emu"
	xdotool search --name "HLE" set_window --classname "dolphin-emu" set_window --class "dolphin-emu"
	# make sure said window is active
	xdotool search --class "dolphin-emu" windowactivate
}

## Launch games with PCSX2
# This requires that config files are dumped and used
pcsx2 ()
{
	GAME="$2"
	PCSX2 "/run/media/HDD/ROMs/PS2/$GAME.iso" --cfgpath="/home/kat/.config/PCSX2/configs/$GAME/" \
		--fullscreen --nogui
}

case "$1" in
	(--htop) htop ;;
	(--conky) conky ;;
	(--dolphin) dolphin "$@" ;;
	(--pcsx2) pcsx2 "$@" ;;
esac
