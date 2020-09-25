#!/bin/sh
if xrandr | grep "^HDMI-1" | grep disconnected ; then
    xrandr --output eDP-1 --auto
else
    xrandr --output eDP-1 --off
    xrandr --output HDMI-1 --size 2560x1440
fi

~/.fehbg
