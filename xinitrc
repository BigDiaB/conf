#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

$HOME/Skripte/tap_click.sh &
$HOME/Skripte/natural_scrolling.sh &
$HOME/Skripte/wallpaper.sh &
$HOME/Skripte/toggle_autorotation.sh &

setxkbmap de

if [ "$($HOME/Skripte/lid_state.sh)" = "" ]; then
	$HOME/Skripte/mirror.sh extern
	xset -dpms
	xset s off
else
	$HOME/Skripte/mirror.sh
fi

$HOME/Skripte/polybar.sh &
$HOME/Skripte/compositor.sh &
$HOME/Skripte/notifications.sh &

xsetroot -cursor_name left_ptr

sxhkd -c $HOME/conf/sxhkd.conf &
exec bspwm -c $HOME/conf/bspwm.conf
