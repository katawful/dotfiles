#!/bin/sh

## This script copies and pastes the current clipboard buffer to the CSE script editor

main()
{
	cse_script="CSE Script Editor"

	# get the currently active script window
	active_script=$(xdotool search --name "$cse_script" getwindowname | awk '{print $1}')

	# check if CSE is even running
	# 0 if its running, else 1
	cse_active=$(xdotool search --class "tesconstructionset.exe"; echo $?)
	cse_active=$(echo "$cse_active" | tail -1)	# xdotool spits out ids, i only need last line
	# clear out the buffer for neatness sake
	clear
	# see if CSE is running, if not complain
	if [[ $cse_active == 1 ]]; then
		read -n 1 '-d ' -sp "CSE not open, would you like to open it? (y/n)" scriptmenu
		if [[ $scriptmenu == 'y' ]]; then
			cse_open
			exit 0
		elif [[ $scriptmenu == 'n' ]]; then
			clear
			echo "CSE must be open, exiting now"
			xdotool windowactivate "$previous_window"
			exit 1
		fi
	else
		continue
	fi

	# simple check to see if the variable is empty or not
	if [ -z $active_script ]; then
		read '-d ' -n 1 -sp "Script window closed, would you like to open one? (y/n)" scriptmenu
		if [[ $scriptmenu == 'y' ]]; then
			script_open
		elif [[ $scriptmenu == 'n' ]]; then
			clear
			echo "Script window needs to be open, exiting now"
			xdotool windowactivate "$previous_window"
			exit 0
		fi
	fi
	sleep 0.9
	# run the search script function
	get_script
}

## This opens up CSE if it was not open
cse_open()
{
	cd "$HOME/.obl/drive_c/Oblivion/"
	# put all stdout into a null dev
	WINEPREFIX=~/.obl wine obse_loader.exe -editor -notimeout &>/dev/null
}

## This opens up a script window
script_open()
{
	# activate main CSE window, xdotool wasn't working here
	wmctrl -a "TES Construction Set"
	active_window=$(xdotool getactivewindow)
	# this opens up toolbar and opens window
	xdotool mousemove --window "$active_window" 240 10
	xdotool click 1
	xdotool mousemove_relative 0 80
	xdotool click 1
}

## This opens up the script with the correct name if it exists
get_script()
{
	scriptid=$(xdotool search --name "CSE Script Editor" getwindowname | awk '{print $1}')
	# see if file is valid: ie exists and is the right file type
	if [[ -f "$work_scriptfile" ]] && [ "${work_scriptfile: -4}" == ".obl" ]; then
		continue
	else
		clear
		echo "Invalid file, exiting script"
			xdotool windowactivate "$previous_window"
		exit 1
	fi
	script_name=$(head -n 1 "$work_scriptfile" | awk '{print $2}')
	scriptid_lower=$(echo "$script_name" | awk '{print tolower($0)}')
	
	## compare the file name to the script name
	# if the proper script window is already open
	if [[ "$scriptid" == "$script_name" ]]; then
		# since the windows are the same we can just activate it
		wmctrl -a "CSE Script Editor"
		active_window=$(xdotool getactivewindow)
		# add file contents to our system clipboard
		xclip -sel c < "$work_scriptfile"
		# select all, paste, then save
		xdotool mousemove --window "$active_window" 500 500
		sleep 0.4
		xdotool click 1
		xdotool key "ctrl"+a
		xdotool key "ctrl"+v
		xdotool key "ctrl"+s
		xdotool windowactivate "$previous_window"
	# else if its not open
	else
		wmctrl -a "CSE Script Editor"
		active_window=$(xdotool getactivewindow)
		xclip -sel c < "$work_scriptfile"
		xdotool mousemove --window "$active_window" 500 500
		xdotool click 1
		xdotool key "ctrl"+o
		xdotool type --window "$active_window" "$scriptid_lower"
		sleep 0.4
		xdotool key Return
		sleep 1
		active_windowname=$(xdotool getactivewindow getwindowname)
		# if the search is empty, break out
		if [[ "$active_windowname" == "Open Script(s)" ]]; then
			clear
			echo "No script found, please make your own"
			wmctrl -c "Open Script(s)"	# I use wmctrl here since xdotool wasn't working
			xdotool windowactivate "$previous_window"
			exit 0
		fi
		sleep 0.4
		# two clicks were needed here, AvalonEdit is picky about keyboard focus
		xdotool click 1
		xdotool click 1
		xdotool key "ctrl"+a
		xdotool key "ctrl"+v
		xdotool key "ctrl"+s
		xdotool windowactivate "$previous_window"
	fi
}

# get the proper file, this is inserted from a vimscript
read '-d ' work_scriptfile

# get the previous window so we can jump back to it
previous_window=$(xdotool getactivewindow)
main
