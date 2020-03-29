#!/bin/zsh

#set window title
echo -ne "\033]0;"conky"\007"

#runs conky with my custom menu in terminal
conky -c ~/.config/conky/conky.conf
