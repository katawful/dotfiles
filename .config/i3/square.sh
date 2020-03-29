#!/bin/sh

# this captures a rectangle in scrot

# get current time and date
YEAR=$(date +"%Y")
MONT=$(date +"%m")
DAY=$(date +"%d")
TIME=$(date +"%T")
# combine them how i want to
FILE="$YEAR-$MONT-$DAY~$TIME"

scrot -s ~/Pictures/RECTANGLE/$FILE.png
