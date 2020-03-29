#!/bin/zsh

# kill conky instances
killall -q conky

# wait until processes have been shut down
while pgrep -u $UID -x conky >/dev/null; do sleep 1; done

# launch conky
conky -c ~/.config/conky/conky.conf &

