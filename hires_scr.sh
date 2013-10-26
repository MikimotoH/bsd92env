#!/bin/sh
# https://www.dan.me.uk/blog/2012/05/06/text-console-resolution-and-geometry-settings-in-freebsd-9-x/
# vidcontrol -i mode < /dev/console
# vidcontrol -g 132×60 MODE_261 < /dev/console
echo allscreens_flags=" -g 132×60 MODE_261" >> /etc/rc.conf
echo vesa_laod="YES" >> /boot/loader.conf
