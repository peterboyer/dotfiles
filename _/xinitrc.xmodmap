#!/bin/sh

sysmodmap=/etc/X11/xinit/.Xmodmap
usermodmap=$HOME/.Xmodmap

if [ -f "$sysmodmap" ]; then xmodmap "$sysmodmap"; fi
if [ -f "$usermodmap" ]; then xmodmap "$usermodmap"; fi
