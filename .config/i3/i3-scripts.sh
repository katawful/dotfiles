#!/bin/sh

# This contains various scripts for i3 that can't be put in its config

## Toggle second monitor workspaces
# This script is meant ot toggle the second monitor workspace for my convenience
i3secondmonitor ()
{
	active_workspace=$(i3-msg -t get_workspaces |\
		jq '.[] | select(.focused==true).name' |\
		cut -d"\"" -f2)
	visible_workspace_1=$(i3-msg -t get_workspaces |\
		jq '.[] | select(.name=="Second Monitor: 1").visible' |\
		cut -d"\"" -f2)
	visible_workspace_2=$(i3-msg -t get_workspaces |\
		jq '.[] | select(.name=="Second Monitor: 2").visible' |\
		cut -d"\"" -f2)
	workspace_1="Second Monitor: 1"
	workspace_2="Second Monitor: 2"
	# check if we aren't on the second monitor
	if [[ "$active_workspace" != "$workspace_1" ]] && [[ "$active_workspace" != "$workspace_2" ]]; then
		# move to the visible workspace if we aren't on the second monitor
		if [[ "$visible_workspace_1" == "true" ]]; then
			i3-msg workspace $workspace_1
		elif [[ "$visible_workspace_2" == "true" ]]; then
			i3-msg workspace $workspace_2
		fi
	# check if we are on the second monitor
	# then toggle between
	elif [[ "$active_workspace" == "$workspace_1" ]]; then
		i3-msg workspace $workspace_2
	elif [[ "$active_workspace" == "$workspace_2" ]]; then
		i3-msg workspace $workspace_1
	fi
}

i3multimonitor ()
{
	MON_LIST=$(xrandr --listactivemonitors | awk {'print $4'})
	total=$(echo "$MON_LIST" | wc -l)
	MON_ONE=$(echo "$MON_LIST" | awk 'FNR == 2 {print}')
	MON_TWO=$(echo "$MON_LIST" | awk 'FNR == 3 {print}')
	MON_THREE=$(echo "$MON_LIST" | awk 'FNR == 4 {print}')
	# sleep 2
	# xrandr --output "$MON_ONE" --primary --pos 1920x420
	# xrandr --output "$MON_TWO" --pos 0x420
	# xrandr --output "$MON_THREE" --rotate right --pos 3840x0
	sleep 2
	xrandr --output "$MON_ONE" --primary --pos 0x420
	xrandr --output "$MON_TWO" --pos 0x420 --left-of "$MON_ONE"
	xrandr --output "$MON_THREE" --pos 2760x0 --rotate right --right-of "$MON_THREE"
	sleep 2
	nitrogen --restore &

}

i3idle() {
  # Run xidlehook
  xidlehook \
    --not-when-fullscreen \
    --not-when-audio \
    --timer 600 \
    'betterlockscreen -l dimblur' \
    '' \
    --timer 3600 \
    'systemctl suspend' \
    ''
}

case "$1" in
	(--second) i3secondmonitor ;;
    (--idle) i3idle ;;
		(--monitorsetup) i3multimonitor ;;
esac
