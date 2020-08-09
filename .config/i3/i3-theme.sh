#!/bin/sh

# This command checks the current time and sets wal properly on loading i3

main ()
{
	TIME=$(date +"1%H%M")
	THEM=$(cat "/home/kat/.cache/wal/theme")
	STAT=$(cat "/home/kat/.cache/wal/stat")

	# this is when we exit i3 and need to restart the theme
	if [[ $STAT = "none" ]]; then
		notheme
	fi
	
	# once reset, see if the theme needs to be changed
	if [[ $STAT = "reset" ]]; then
		# time between 0:00-7:00
		if [[ $TIME -lt 10700 && $TIME -gt 10000 ]]; then
				night
		# time between 7:00-18:29
		elif [[ $TIME -ge 10700 && $TIME -lt 11830 ]]; then
				dusk
		# time between 18:30-20:00
		elif [[ $TIME -gt 11830 && $TIME -lt 12000 ]]; then
				dusk
		# time betwen 20:00-24:00
		elif [[ $TIME -gt 12000 && $TIME -lt 12400 ]]; then
				night
		fi
	fi
}

notheme ()
{
	wal -R
	echo "reset" > "/home/kat/.cache/wal/stat"
	main
}

day ()
{
	#wal --theme "/home/kat/.config/wal/colorschemes/light/base16-gruvbox-soft.json"
	wal --theme sexy-s3r0-modified
	redshift -PO 5700
	echo "day" > "/home/kat/.cache/wal/theme"
	# change conky theme
	rm /home/kat/.config/conky/conky.conf
	cp /home/kat/.config/conky/conky-light.conf /home/kat/.config/conky/conky.conf
}

dusk ()
{
#	wal --theme "/home/kat/.config/wal/colorschemes/dark/base16-gruvbox-soft.json"
	wal --theme sexy-s3r0-modified
	redshift -PO 5700
	echo "dusk" > "/home/kat/.cache/wal/theme"
	# change conky theme
	rm /home/kat/.config/conky/conky.conf
	cp /home/kat/.config/conky/conky-dark.conf /home/kat/.config/conky/conky.conf
}

night ()
{
#	wal --theme "/home/kat/.config/wal/colorschemes/dark/base16-gruvbox-soft.json"
	wal --theme sexy-s3r0-modified
	redshift -PO 3500
	echo "night" > "/home/kat/.cache/wal/theme"
	# change conky theme
	rm /home/kat/.config/conky/conky.conf
	cp /home/kat/.config/conky/conky-dark.conf /home/kat/.config/conky/conky.conf
}

# run the main script
#sleep 11
main
