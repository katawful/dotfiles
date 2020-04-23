#!/bin/zsh

# this command checks the current time and sets wal properly on loading i3
# this also seems to be zsh specific, it's not POSIX compliant

TIME=$(date +"1%H%M")
THEM=$(cat /tmp/theme)
STAT=$(cat /tmp/stat)

if [[ $STAT = "none" ]]; then
	sh /home/kat/.config/i3/no-theme.sh
fi

if [[ $STAT = "reset" ]]; then
	# time between 0:00-7:00
	if [[ $TIME -lt 10700 && $TIME -gt 10000 ]]; then
		if [[ $THEM = "night" ]]; then
			exit
		else
			sh /home/kat/.config/i3/night.sh
		fi
	# time between 7:00-18:29
	elif [[ $TIME -ge 10700 && $TIME -lt 11830 ]]; then
		if [[ $THEM = "day" ]]; then
			exit
		else
			sh /home/kat/.config/i3/day.sh
		fi
	# time between 18:30-20:00
	elif [[ $TIME -gt 11830 && $TIME -lt 12000 ]]; then
		if [[ $THEM = "dusk" ]]; then
			exit
		else
			sh /home/kat/.config/i3/dusk.sh
		fi
	# time betwen 20:00-24:00
	elif [[ $TIME -gt 12000 && $TIME -lt 12400 ]]; then
		if [[ $THEM = "night" ]]; then
			exit
		else
			sh /home/kat/.config/i3/night.sh
		fi
	fi
fi
