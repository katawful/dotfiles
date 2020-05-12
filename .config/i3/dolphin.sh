#!/bin/sh

FILE=$2 # filename
SYS=$1 # system

# run dolphin in background
dolphin-emu-nogui -e "/run/media/HDD/ROMs/$SYS/$FILE" &
# wait two seconds
sleep 2s
# set the window class to "dolphin-emu"
xdotool search --name "HLE" set_window --classname "dolphin-emu" set_window --class "dolphin-emu"
# make sure said window is active
xdotool search --class "dolphin-emu" windowactivate

