#!/bin/sh
# this script keeps my tablet on my primary display

ID=$(xinput | grep "HID 256c:006d Pen stylus" | grep pointer | awk '{print substr($7, 4, 5)}')
MON=$(xrandr | grep primary | awk '{print $1}')

xinput map-to-output $ID $MON

xsetwacom --set 'HID 256c:006d Pad pad' Button 1 "key +ctrl +z -z -ctrl"
xsetwacom --set 'HID 256c:006d Pad pad' Button 2 "key e"
xsetwacom --set 'HID 256c:006d Pad pad' Button 3 "key b"
xsetwacom --set 'HID 256c:006d Pad pad' Button 8 "key +"
xsetwacom --set 'HID 256c:006d Pad pad' Button 9 "key -"
xsetwacom --set 'HID 256c:006d Pad pad' Button 10 "key p"
xsetwacom --set 'HID 256c:006d Pad pad' Button 11 "key ["
xsetwacom --set 'HID 256c:006d Pad pad' Button 12 "key p"
xsetwacom --set 'HID 256c:006d Pen stylus' Button 3 "key +ctrl +shift p -shift -ctrl"
