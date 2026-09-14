#!/bin/sh

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# clipmenu daemon
clipmenud &

# bar
"$SCRIPT_DIR/bar.sh" &

# keyboard
xkbcomp ~/.config/xkb/my $DISPLAY
# setxkbmap -layout us,ru -option grp:win_space_toggle

# cursor
export XCURSOR_THEME=breeze_cursors
export XCURSOR_SIZE=36

# scaling
xrdb -merge <<EOF
Xft.dpi: 120
EOF

export GDK_SCALE=1
export GDK_DPI_SCALE=1.25
export QT_SCALE_FACTOR=1.25

exec dwm

