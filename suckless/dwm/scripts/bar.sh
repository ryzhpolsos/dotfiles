#!/bin/sh

echo $$ > /run/user/$UID/bar_updater.pid

while true; do
    status=""

    # keyboard layout
    layout=$(xkblayout-state print '%n')
    [ "$layout" == "English" ] && status="en"
    [ "$layout" == "Russian" ] && status="ru"

    # wifi status
    wifinet=$(nmcli device | grep 'wifi[ ]*connected' | cut -F4)
    if [ -z "$wifinet" ]; then
        status="$status | 🛜🚫"
    else
        status="$status | 🛜 $wifinet"
    fi

    # battery
    battstate=""
    rawstate=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep state | cut -F3)
    percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage | cut -F3)
    [ $rawstate == "charging" -o $rawstate == "fully-charged" ] && battstate="🔌"

    status="$status | $battstate🔋 $percentage"

    # volume
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | cut -d/ -f2 | xargs)
    status="$status | 🔊 $volume"

    # date
    status="$status | $(date +'%H:%M %d.%m.%Y')"

    xsetroot -name " $status "

    sleep 0.1 
done
