#!/bin/sh

#this script changes the colors to gruvbox light and deactivates redshift

wal --theme base16-gruvbox-soft -l
redshift -PO 5700
echo "day" > /tmp/theme
# change conky theme
rm /home/kat/.config/conky/conky.conf
cp /home/kat/.config/conky/conky-light.conf /home/kat/.config/conky/conky.conf
