#!/bin/sh
#
# ~/.xinitrc

# NEW ====
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
# END NEW ====

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec wal -i ~/bgImages/bg14.jpg -a 90 --saturate 0.7
exec i3
exec ~/.bash_profile

