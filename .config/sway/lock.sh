#!/bin/bash
OUTPUTS=`swaymsg -t get_outputs -r | jq -r '.[] | .name | strings'`


for output in "$OUTPUTS" 
do 
    grim -o $output - | convert -blur 0x8 - /tmp/$output-lock.png &
done
wait
ARGS=`echo $OUTPUTS | awk '{print "-i "$1":/tmp/"$1"-lock.png"}'`
swaylock $ARGS
rm /tmp/*-lock.png
