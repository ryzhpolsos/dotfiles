#!/bin/sh

current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | cut -d/ -f2 | sed 's/[^0-9]//g')
(( current_volume += $1 ))
pactl set-sink-volume @DEFAULT_SINK@ ${current_volume}%
