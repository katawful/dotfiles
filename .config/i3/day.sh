#!/bin/sh

#this script changes the colors to gruvbox light and deactivates redshift

wal --theme base16-gruvbox-soft -l
redshift -PO 5700
echo "day" > ~/.config/i3/current-theme
# change conky theme
rm ~/.config/conky/conky.conf
cp ~/.config/conky/conky-light.conf ~/.config/conky/conky.conf
