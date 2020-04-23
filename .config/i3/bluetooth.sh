#!/bin/sh

# this creates a simple menu that lets me control bluetooth stuff

case "$1" in
	disconnect)
		echo -e "disconnect\n" | bluetoothctl
		;;
	open-bluetoothctl)
		kitty bluetoothctl
		;;
	*)
		echo "Usage: $0 {disconnect|open-bluetoothctl}"
		exit 2
esac

exit 0
