#!/bin/sh

#this script changes the colors to gruvbox dark and keeps no redshift

wal --theme base16-gruvbox-soft
redshift -PO 5700
echo "dusk" > /home/kat/.config/i3/current-theme
# change conky theme
rm /home/kat/.config/conky/conky.conf
cp /home/kat/.config/conky/conky-dark.conf /home/kat/.config/conky/conky.conf
