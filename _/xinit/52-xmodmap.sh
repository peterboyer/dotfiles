#!/bin/sh

if [ -n "$XENV" ]; then sleep 2; fi

sysmodmap=/etc/X11/xinit/.Xmodmap
usermodmap=$HOME/.Xmodmap

if [ -f "$sysmodmap" ]; then xmodmap "$sysmodmap"; fi
if [ -f "$usermodmap" ]; then xmodmap "$usermodmap"; fi
