#!/bin/sh

#this script changes the colors to gruvbox dark and keeps no redshift

wal --theme base16-gruvbox-soft
redshift -PO 5700
echo "dusk" > ~/.config/i3/current-theme
# change conky theme
rm ~/.config/conky/conky.conf
cp ~/.config/conky/conky-dark.conf ~/.config/conky/conky.conf
