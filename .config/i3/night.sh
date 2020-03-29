#!/bin/sh

#this script changes the colors to gruvbox dark and activates redshift

wal --theme base16-gruvbox-soft
redshift -PO 3500
echo "night" > ~/.config/i3/current-theme
# change conky theme
rm ~/.config/conky/conky.conf
cp ~/.config/conky/conky-dark.conf ~/.config/conky/conky.conf
