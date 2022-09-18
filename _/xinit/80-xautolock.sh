#!/bin/sh

xautolock -time 10 -locker "systemctl suspend" -detectsleep &
