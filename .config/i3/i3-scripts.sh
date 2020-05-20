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

case "$1" in
	(--second) i3secondmonitor ;;
esac
