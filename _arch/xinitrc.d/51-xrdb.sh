#!/bin/sh

sysresources=/etc/X11/xinit/.Xresources
userresources=$HOME/.Xresources

if [ -f "$sysresources" ]; then xrdb -merge "$sysresources"; fi
if [ -f "$userresources" ]; then xrdb -merge "$userresources"; fi
