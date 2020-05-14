#!/bin/sh

# this script contains all of my various dmenu related options and scripts
# it gets expanded as I need it
# i tried to do everything in dmenu with rofi for maximum compatibility



# this activates a dmenu that shows our active windows and lets us go to them
i3activewindow ()
{
	rownum=1				# start row at 1
	totrow=$(wmctrl -l | grep "" -c)	# show total rows
	while [ $rownum -le $totrow ]		# while current row is <= total row
	do
		# print the window name for the current row of wmctrl
		win=$(wmctrl -l | awk -v a="$rownum" 'FNR == a {print}' | cut -c 24-)
		# add the result to a total list separated by line break
		listwin="${listwin}$win\n"
		# increment row number to complete condition
		rownum=$(($rownum+1))
	done
	choice=$(echo -e "$listwin" | dmenu -i -l 6)	# offload list to a choice
	winid=$(xdotool search --name "$choice") # get the window id so we can activate it
	if [ -z "$choice" ]; then		# if we didn't choose anything, this stops the script from exiting in an error
		exit 1
	else
		xdotool windowactivate $winid	# activate said window
		exit 1
	fi
}

# this gets the window name of the active window and prepends the mark name if it exists
i3windowid ()
{
	winstatus=$(xdotool getactivewindow)
	# check if a window even exists
	if [ $? -ne 0 ]; then
		echo ""
		exit 1
	else
		rownum=1	# start rownum
		# get total rows
		totrow=$(i3-msg -t get_tree | jq '.. | objects | .name,.marks' | \
			grep -B1 -A1 "[[]" | tr -d "\\n["  | sed 's/--/\n/g' | \
			grep "" -c)
		# get active window
		win=$(xdotool getactivewindow getwindowname)
		# search through rows of marks
		while [ $rownum -le $totrow ]
		do
			# get the mark window
			markwin="$(i3-msg -t get_tree | jq '.. | objects | .name,.marks' | \
				grep -B1 -A1 "[[]" | tr -d "\\n["  | sed 's/--/\n/g' | \
				awk -v a="$rownum" 'FNR == a {print}' | cut -d '"' -f2)"
			# if we found the correct mark
			if [[ $markwin == $win ]]; then
				break	# leave loop if we got the mark
			else
				rownum=$(($rownum+1))
			fi
		done

		# see if we even need to use the mark
		# if we reached the end of the rows and our mark window doesn't match our active one
		if [[ $rownum == $totrow ]] && [[ $markwin != $win ]]; then
			mark=""
		else
			mark="$(i3-msg -t get_tree | jq '.. | objects | .name,.marks' | \
				grep -B1 -A1 "[[]" | tr -d "\\n["  | sed 's/--/\n/g' | \
				awk -v a="$rownum" 'FNR == a {print}' | cut -d '"' -f4)"
		fi

		
		# shorten window name if too long
		if [ ${#win} -gt 60 ]; then
			win="$(echo $win | cut -c 1-60)..."
		fi

		# prepend mark if it exists
		if [ -z "$mark" ]; then
			echo "$win"
			exit 1
		else
			echo " $mark $win"
			exit 1
		fi
	fi
}

# this creates marks for our apps
# this is mostly inspired/copied from EllaTheCat's i3 config
i3createmark ()
{
	while : ; do
		id=$((10#$(date +%N) % 100))
		id=$(printf "%02d" "${id}")
		count=$(for m in $(i3-msg -t get_marks | grep '[0-9][0-9]' | sed 's/,/\ /g');
			do echo "${m}"; done | grep -c "${id}")
		if [ "${count}" -eq 0 ]; then break; fi
	done
	sleep 1 # No need for caller to wait for the window.
	windowid=$(printf "0x%x" "$(xdotool getwindowfocus)")
	i3-msg "[id=\"${windowid}\"] mark --toggle \"${id}\""
	i3-msg "[con_mark=\"${id}\"] focus"
}

# this opens a dmenu to search through my marks
# again mostly copied from EllaTheCat's config
i3searchmark ()
{
	# ella mentions that jq has issues but seems ok for me
	menu="$(i3-msg -t get_tree | jq '.. | objects | .name,.marks' | \
		grep -B1 -A1 "[[]" | tr -d "\\n["  | sed 's/--/\n/g')"
	pair=$(echo "${menu}" | dmenu -i -l 6) 

	for s in ${pair}; do mark=${s/,/}; done
	if [ "_${mark}" != "_" ]; then
		i3-msg "[ con_mark=${mark} ] focus"
		i3-msg "[ con_mark=${mark} ] move workspace to output $2"
	fi
}

# this opens up my modding setup
openmodding ()
{
	cd ~/Programming/oblivion-git && kitty "nvim" &
	cd ~/.obl/drive_c/Oblivion
	WINEPREFIX=~/.obl winetricks isolate_home && \
		WINEPREFIX=~/.obl wine \
		~/.obl/drive_c/Oblivion/obse_loader.exe -editor -notimeout
	
}

# this opens up my C++ studying setup
opencplusplus ()
{
	cd ~/Programming/My-Tests/C++/C++\ Primer\ Exerices && kitty "nvim" &
}

# this shows a menu of the things we can launch
openthings ()
{
	choice=$(echo -e "Launch CSE\nLaunch C++ Studying" | dmenu -i -l 6)
	if [[ $choice == "Launch CSE" ]]; then
		openmodding
	elif [[ $choice == "Launch C++ Studying" ]]; then
		opencplusplus
	fi
}


# the things we can run
case "$1" in
	(--active) i3activewindow ;;
	(--window-name) i3windowid ;;
	(--marks) i3searchmark ;;
	(--create-mark) i3createmark ;;
	(--modding) openmodding ;;
	(--open) openthings ;;
esac
