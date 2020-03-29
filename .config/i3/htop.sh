#!/bin/zsh

#set window title
echo -ne "\033]0;"htop"\007"

# run htop
kitty "htop"
