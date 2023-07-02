{ pkgs }:

with pkgs;

writeScriptBin "appmenu" ''
#/usr/bin/env sh
rofi -show drun \
     -modi drun,run \
     -show-icons \
     -theme ~/.config/rofi/appmenu.rasi
''
