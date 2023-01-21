#!/bin/sh

xautolock -time 10 -locker "systemctl suspend" -notify 10 -detectsleep &
