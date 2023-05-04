#!/bin/bash

if [[ "$(whoami)" != "root" ]]; then
	echo "This script must be run as root!"
	exit
fi


SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

cd $DIR

cp 20-intel.conf ~/etc/X11/xorg.conf.d/
cp *.desktop /usr/share/applications/
pacman -U ttf-ms-win10-10.0.19043.1055-1-any.pkg.tar.zst
echo "Please manually copy 'firefox_prefs.js' to a similar location like '/home/Benjaminemde/.mozilla/firefox/wxq0u1r9.default-release/prefs.js'!"
