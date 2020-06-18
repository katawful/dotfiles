#!/bin/zsh

# terminate running bar instances
killall -q polybar

# wait until processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch polybar with default config location (~/.config/polybar/config)
polybar bottombar &
polybar topbar &

echo "Polybar launched..."

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar --reload topbar &
		MONITOR=$m polybar --reload bottombar &
	done
else
	polybar --reload bottombar &
	polybar --reload topbar &
fi
