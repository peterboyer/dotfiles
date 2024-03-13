#!/bin/bash

sudo sed -i "s|\(\"XkbOptions\"\) \".\+\"|\1 \"terminate:ctrl_alt_bksp,caps:ctrl_modifier,altwin:swap_lalt_lwin\"|" /etc/X11/xorg.conf.d/00-keyboard.conf
