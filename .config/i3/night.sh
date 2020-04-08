#!/bin/sh

#this script changes the colors to gruvbox dark and activates redshift

wal --theme base16-gruvbox-soft
redshift -PO 3500
echo "night" > /home/kat/.config/i3/current-theme
# change conky theme
rm /home/kat/.config/conky/conky.conf
cp /home/kat/.config/conky/conky-dark.conf /home/kat/.config/conky/conky.conf
