#!/bin/sh

name=$(cat /proc/$(xdotool getactivewindow getwindowpid)/comm)
sink=$(pacmd list-sink-inputs | awk "/index/ { SN = \$2 } /application.process.binary/ { gsub(/\"/, \"\", \$3); if(\$3 == \"$name\"){ print SN } }")
mute_status=$(pacmd list-sink-inputs | awk "/index/ { SN = \$2 } /muted/ { if(SN == $sink){ print \$2 } }")

if [ "$mute_status" == "yes" ]; then
    pacmd set-sink-input-mute $sink 0
else
    pacmd set-sink-input-mute $sink 1
fi
