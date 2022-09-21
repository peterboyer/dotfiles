#!/bin/sh

echo "XENV=$XENV" >> /home/admin/test.log
if [ -n "$XENV" ]; then sleep 2; fi

sysmodmap=/etc/X11/xinit/.Xmodmap
usermodmap=$HOME/.Xmodmap

echo "invoke $0: HOME=$HOME usermodmap=$usermodmap" >> /home/admin/test.log

if [ -f "$sysmodmap" ]; then xmodmap "$sysmodmap"; fi
if [ -f "$usermodmap" ]; then xmodmap "$usermodmap"; fi
