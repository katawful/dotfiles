#!/bin/zsh

# this command checks the current time and sets wal properly on loading i3
# this also seems to be zsh specific, it's not POSIX compliant

TIME=$(date +"%H%M")

# time between 0:00-7:00
if [[ $TIME -lt 700 && $TIME -gt 0000 ]]; then
	sh ~/.config/i3/night.sh
# time between 7:00-18:29
elif [[ $TIME -ge 0700 && $TIME -lt 1830 ]]; then
	sh ~/.config/i3/day.sh
# time between 18:30-20:00
elif [[ $TIME -gt 1830 && $TIME -lt 2000 ]]; then
	sh ~/.config/i3/dusk.sh
# time betwen 20:00-24:00
elif [[ $TIME -gt 2000 && $TIME -lt 2400 ]]; then
	sh ~/.config/i3/night.sh
fi
